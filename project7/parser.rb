C_ARITHMETIC = 1
C_PUSH = 2
C_POP = 3
C_LABEL = 4
C_GOTO = 5
C_IF = 6
C_FUNCTION = 7
C_RETURN = 8
C_CALL = 9

class Parser
  attr_accessor :file_array, :file_length, :current_command

  def initialize(filename)
    @file_array = []
    @file_length = 0
    @current_command = ""
    @current_pointer = 0

    File.open(filename) do |file|
      file.each_line do |line|
        line = format_line(line)
        next if line.match(/^.*\/\//)
        next if line == ""
        @file_array << line
      end
    end
    p @file_array
    @file_length = @file_array.length
  end

  def advance
    @current_command = @file_array[@current_pointer]
    @current_pointer += 1
  end

  def has_more_commands?
    @current_pointer < @file_length
  end

  def command_type(command)
    if command.match(/^add|^sub|^neg|^eq|^gt|^lt|^and|^or|^not/)
      C_ARITHMETIC
    elsif command.match(/^push/)
      C_PUSH
    elsif command.match(/^pop/)
      C_POP
    elsif command.match(/^label/)
      C_LABEL
    elsif command.match(/^goto/)
      C_GOTO
    elsif command.match(/^if\-goto/)
      C_IF
    elsif command.match(/^function/)
      C_FUNCTION
    elsif command.match(/^return/)
      C_RETURN
    elsif command.match(/^call/)
      C_CALL
    else
      raise "不正なコマンド", command
    end
  end

  def arg1
    case command_type(@current_command)
    when C_ARITHMETIC
      @current_command
    else
      @current_command.split(" ")[1]
    end
  end

  def arg2
    @current_command.split(" ")[2].to_i
  end

  def format_line(line)
    line = line.chomp
    reg = /\/\//.match(line) unless line == ""
    line = reg.pre_match if reg
    line.strip
  end
end

parser = Parser.new("test.vm")

parser.file_length.times do
  parser.advance
  p "#{parser.current_command}, #{parser.command_type(parser.current_command)}"
end
