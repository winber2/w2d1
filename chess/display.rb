require_relative "board"
require_relative "cursor"

class Display

  def initialize(board = Board.new)
    @board = board
    @cursor = Cursor.new([0,0], board)
  end

  def render
    puts "  #{(0..7).to_a.join(" ")}"
    @board.grid.each_with_index do |row, idx|
      puts "#{idx} #{row.join(" ")}"
    end
  end

  def show
    input = nil
    @board[[0,0]] = " ".colorize(:background => :blue)
    render
    while input.nil?
      input = @cursor.get_input
      next if input.nil?
      @board[input] = " ".colorize(:background => :blue)
      render
    end
  end
end
