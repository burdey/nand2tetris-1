require './parser.rb'
require './code_writer.rb'

class Main
  def initialize
    filename = ARGV[0]
    result_name = ARGV[1]
    @parser = Parser.new(filename)
    @code_writer = CodeWriter.new
    result = ""
    p @parser.file_length
    @parser.file_length.times do
      @parser.advance
      command = @parser.command_type(@parser.current_command)
      case command
      when C_PUSH, C_POP
        p @code_writer.write_push_pop(command, @parser.arg1, @parser.arg2)
        result += @code_writer.write_push_pop(command, @parser.arg1, @parser.arg2)
      when C_ARITHMETIC
        p @code_writer.write_arithmetic(@parser.current_command)
        result += @code_writer.write_arithmetic(@parser.current_command)
      end
    end

    File.open(result_name, "w") do |f|
      f.puts(result)
    end
  end
end

Main.new
