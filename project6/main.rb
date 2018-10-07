require 'pry'
require './parser.rb'
require './code.rb'

class Main
  def initialize
    parser = Parser.new("PongL.asm")
    result = ""
    parser.file_length.times do
      case parser.commandType
      when A_COMMAND
        result += convert_to_bit(parser.symbol)
      when C_COMMAND
        result += "#{"111" + Code.comp(parser.comp) + Code.dest(parser.dest) + Code.jump(parser.jump)}"
      when L_COMMAND
        result += "LABELは今考慮してない。"
      else
        raise "current_command=#{parser.current_command}"
      end
      result += "\n"
      parser.advance
    end
    File.open("PongL.hack", "w") do |f|
      f.puts(result)
    end
  end

  def convert_to_bit(num)
    result = []
    num = num.to_i
    16.times do
      result.unshift(num % 2)
      num = num / 2
    end
    result.join
  end
end

Main.new()
