class CodeWriter
  def initialize
    @label_counter = -1
  end

  def set_file_name
  end

  def write_arithmetic(command)
  end

  def write_push_pop(command, segment, index)
    case command
    when C_PUSH
      case segment
      when "constant"
        <<-EOF
          @#{index}
          D=A
          @SP
          A=M
          M=D
          @SP
          M=M+1
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
