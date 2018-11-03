require './parser.rb'
require './code_writer.rb'

class Main
  def initialize
    filename_array = []
    (ARGV.length-1).times do |i|
      filename_array << ARGV[i]
    end
    result_name = ARGV[-1]
    # INIT
    @result = <<-EOF
        @256
        D=A
        @SP
        M=D
      EOF

    @result += CodeWriter.new("").write_call("Sys.init", 0)

    filename_array.each do |filename|
      p filename
      @parser = Parser.new(filename)
      @code_writer = CodeWriter.new(filename)
      write_code
    end

    File.open(result_name, "w") do |f|
      f.puts(@result)
    end
  end

  def write_code
      @parser.file_length.times do
        @parser.advance
        command = @parser.command_type(@parser.current_command)
        case command
        when C_PUSH, C_POP
          # p @code_writer.write_push_pop(command, @parser.arg1, @parser.arg2)
          @result += @code_writer.write_push_pop(command, @parser.arg1, @parser.arg2)
        when C_LABEL
          @result += @code_writer.write_label(@parser.arg1)
        when C_GOTO
          @result += @code_writer.write_goto(@parser.arg1)
        when C_IF
          @result += @code_writer.write_if(@parser.arg1)
        when C_CALL
          @result += @code_writer.write_call(@parser.arg1, @parser.arg2)
        when C_RETURN
          @result += @code_writer.write_return
        when C_FUNCTION
          @result += @code_writer.write_function(@parser.arg1, @parser.arg2)
        when C_ARITHMETIC
          # p @code_writer.write_arithmetic(@parser.current_command)
          @result += @code_writer.write_arithmetic(@parser.current_command)
        end
      end
  end
end

Main.new
