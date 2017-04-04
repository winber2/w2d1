require_relative "board"
require_relative "display"

class Game
  attr_reader :board, :display

  def initialize(board = Board.new)
    @board = board
    @display = Display.new(board)
  end

  def play
    begin
      until over?
        @display.show
        system('clear')
      end
    rescue
      puts "Invalid move"
      retry
    end
  end

  def over?

  end

end
