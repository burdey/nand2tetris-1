require 'pry'
module Parser
  class Parse
    attr_accessor :current_command, :file_length
    A_COMMAND = 1
    C_COMMAND = 2
    L_COMMAND = 3

    def initialize(filename)
      @all_lines = []
      @line_pointer = -1
      File.open(filename) do |file|
        file.each_line do |line|
          line = format_line(line)
          @all_lines << line if line != "" && !line.nil?
        end
      end
      @file_length = @all_lines.length
      @current_command = get_current_command
    end

    def format_line(line)
      line = line.chomp
      reg = /\/\//.match(line) unless line == ""
      line = reg.pre_match if reg
      line.strip
    end

    def hasMoreCommands?
      !@current_command.nil?
    end

    def get_current_command
      @line_pointer += 1
      return nil if @line_pointer == @all_lines.length
      @all_lines[@line_pointer]
    end

    def advance
      return unless hasMoreCommands?
      @current_command = get_current_command
    end

    def commandType
      if @current_command.match(/^@[a-zA-Z_\.\$\:]+[a-zA-Z_\.\$\:0-9]*/)
        @current_command_type = A_COMMAND
        return A_COMMAND
      elsif @current_command.match(/^.+=.+;.+|^.+=.+|^.+;.+/)
        @current_command_type = C_COMMAND
        p "#{@current_command}はC命令です"
        p "#{dest + "=" if dest}#{comp}#{";" + jump if jump}"
        return C_COMMAND
      elsif @current_command.match(/^\([a-zA-Z_\-\.\$\:]+[a-zA-Z_\-\.\$\:0-9]*+\)/)
        @current_command_type = L_COMMAND
        return L_COMMAND
      else
        raise @current_command
      end
    end

    def symbol
      return @current_command[1..-1] if @current_command_type == A_COMMAND
      return @current_command[1..-2] if @current_command_type == L_COMMAND
    end

    def dest
      return nil unless @current_command_type == C_COMMAND
      return nil unless @current_command.match(/^.+=.+;.+|^.+=.+/)
      /\=/.match(@current_command).pre_match
    end

    def comp
      return nil unless @current_command_type == C_COMMAND
      return nil unless @current_command.match(/^.+=.+;.+|^.+=.+|^.+;.+/)
      reg = /^.+\=(.+);.+/.match(@current_command)
      return $+ if reg
      reg = /.+\=(.+)/.match(@current_command)
      return $+ if reg
      reg = /^(.+);.+/.match(@current_command)
      return $+ if reg
    end

    def jump
      return nil unless @current_command_type == C_COMMAND
      return nil unless @current_command.match(/^.+=.+;.+|^.+;.+/)
      /;/.match(@current_command).post_match
    end
  end
end

parser = Parser::Parse.new("Max.asm")

parser.file_length.times do
  parser.commandType
  parser.advance
end
