require 'pry'
require './parser.rb'
require './code.rb'
require './symbol_table.rb'

class Main
  def initialize(filename)
    @symbol_table = SymbolTable.new
    createSymbolTable(filename)

    parser = Parser.new(filename)
    result = ""
    ramAdrress = 16

    parser.file_length.times do
      case parser.commandType
      when A_COMMAND
        if parser.symbol.match(/^[0-9]+/)
          result += convert_to_bit(parser.symbol)
        elsif @symbol_table.contains?(parser.symbol)
          result += convert_to_bit(@symbol_table.getAddress(parser.symbol))
        else
          @symbol_table.addEntry(parser.symbol, ramAdrress)
          result += convert_to_bit(ramAdrress)
          ramAdrress += 1
        end
        result += "\n"
      when C_COMMAND
        result += "#{"111" + Code.comp(parser.comp) + Code.dest(parser.dest) + Code.jump(parser.jump)}"
        result += "\n"
      when L_COMMAND
        # なにもしない
      else
        raise "current_command=#{parser.current_command}"
      end
      parser.advance
    end

    File.open("result.hack", "w") do |f|
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
    result.join.to_s
  end

  def createSymbolTable(filename)
    parser = Parser.new(filename)
    counter = 0
    parser.file_length.times do
      case parser.commandType
      when A_COMMAND
        counter += 1
      when C_COMMAND
        counter += 1
      when L_COMMAND
        @symbol_table.addEntry(parser.symbol, counter)
      else
        raise "current_command=#{parser.current_command}"
      end
      parser.advance
    end
  end
end

Main.new("pong/Pong.asm")
