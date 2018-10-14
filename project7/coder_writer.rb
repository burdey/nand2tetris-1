class CodeWrite
  def initialize(filename)
    @parser = Parser.new(filename)
    @label_counter = 0
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
        result += <<-EOF
          @#{index}
          D=A
          @SP
          A=M
          M=D
          @SP
          M=M+1
        EOF
    end
    when C_ARITHMETIC
      case command
      when "add"
        result += <<-EOF
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
        result += <<-EOF
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
        result += <<-EOF
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
        # まず引き算して、
        # 結果に応じて1か0を保存する
        result += <<-EOF
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
        @label_counter += 1
      when "gt"
        # まず引き算して、
        # 結果に応じて1か0を保存する
        result += <<-EOF
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
        @label_counter += 1
      when "lt"
        # まず引き算して、
        # 結果に応じて1か0を保存する
        result += <<-EOF
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
        @label_counter += 1
      when "and"
        result += <<-EOF
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
        result += <<-EOF
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
        result += <<-EOF
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
end

#
# pop local 1
# @SP
# A=A-1
# D=M
# @LCL
# A=A+1 //n回
# M=D
#
# push constant 21
# @21
# D=A
# @SP
# A=A+1
# M=D
#
# pop local 1
# @SP
# A=A-1
# D=M
# @LCL
