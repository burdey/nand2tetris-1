# DRYとか知らんがなのスタイルだが
# 流石に混乱しそうなのは分けた
def pop_segment(segment, index)
  <<-EOF
    // ↓R13に #{segment}+index を保存
    @#{segment}
    D=M
    @#{index}
    D=D+A
    @R13
    M=D
    // ↑R13に #{segment}+index を保存
    // ↓R13の位置にスタックから値を格納
    @SP
    M=M-1
    A=M
    D=M
    @R13
    A=M
    M=D
  EOF
end

def push_segment(segment, index)
  <<-EOF
  @#{segment}
  D=M
  @#{index}
  D=D+A
  @R13
  M=D
  // R13にsegment+indexの指す位置が格納された。
  @R13
  A=M
  D=M
 EOF
end

class CodeWriter
  def initialize
    @label_counter = -1
  end

  def set_file_name
  end

  def write_arithmetic(command)
  end

  def write_push_pop(command, segment, index)
    if command == C_PUSH
      if segment == "constant"
        result = <<-EOF
          @#{index}
          D=A
        EOF
      elsif segment == "local"
        result = push_segment("LCL", index)
      elsif segment == "argument"
        result = push_segment("ARG", index)
      elsif segment == "this"
        result = push_segment("THIS", index)
      elsif segment == "that"
        result = push_segment("THAT", index)
      elsif segment == "temp"
        result = <<-EOF
          @R5
          D=A
          @#{index}
          D=D+A
          @R13
          M=D
          // R13にtemp+indexの指す位置が格納された。
          @R13
          A=M
          D=M
        EOF
      end
    # スタックポインタを増やす
    result +=
      <<-EOF
        @SP
        A=M
        M=D
        @SP
        M=M+1
      EOF
    elsif command == C_POP
      if segment == "local"
        pop_segment("LCL", index)
      elsif segment == "argument"
        pop_segment("ARG", index)
      elsif segment == "this"
        pop_segment("THIS", index)
      elsif segment == "that"
        pop_segment("THAT", index)
      elsif segment == "temp"
        <<-EOF
          @R5
          D=A
          @#{index}
          D=D+A
          @R13
          M=D
          // ↑R13に R5+index を保存
          @SP
          M=M-1
          A=M
          D=M
          @R13
          A=M
          M=D
        EOF
      end
    end
  end

  def write_arithmetic(command)
    case command
    when "add"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D+M
        M=D
        @SP
        M=M+1
      EOF
    when "sub"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        M=D
        @SP
        M=M+1
      EOF
    when "neg"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        D=-D
        M=D
        @SP
        M=M+1
      EOF
    when "eq"
    @label_counter += 1
      # まず引き算して、
      # 結果に応じて1か0を保存する
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        @TRUE#{@label_counter}
        D;JEQ
        @0
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @NEXT#{@label_counter}
        0;JMP
        (TRUE#{@label_counter})
        @0
        D=A
        D=D-1
        @SP
        A=M
        M=D
        @SP
        M=M+1
        (NEXT#{@label_counter})
      EOF
    when "gt"
      @label_counter += 1
      # まず引き算して、
      # 結果に応じて1か0を保存する
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        @TRUE#{@label_counter}
        D;JGT
        @0
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @NEXT#{@label_counter}
        0;JMP
        (TRUE#{@label_counter})
        @0
        D=A
        D=D-1
        @SP
        A=M
        M=D
        @SP
        M=M+1
        (NEXT#{@label_counter})
      EOF
    when "lt"
      @label_counter += 1
      # まず引き算して、
      # 結果に応じて1か0を保存する
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=M-D
        @TRUE#{@label_counter}
        D;JLT
        @0
        D=A
        @SP
        A=M
        M=D
        @SP
        M=M+1
        @NEXT#{@label_counter}
        0;JMP
        (TRUE#{@label_counter})
        @0
        D=A
        D=D-1
        @SP
        A=M
        M=D
        @SP
        M=M+1
        (NEXT#{@label_counter})
      EOF
    when "and"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D&M
        M=D
        @SP
        M=M+1
      EOF
    when "or"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        @SP
        M=M-1
        A=M
        D=D|M
        M=D
        @SP
        M=M+1
      EOF
    when "not"
      <<-EOF
        @SP
        M=M-1
        A=M
        D=M
        D=!D
        M=D
        @SP
        M=M+1
      EOF
    end
  end
end
