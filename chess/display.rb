require_relative "board"
require_relative "cursor"

class Display
  attr_accessor :board

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
    from = get_input
    to = get_input

    @board.move_piece(from, to)
    render
    nil
  end

  def get_input
    input = nil
    prev_pos = @cursor.cursor_pos
    @board[prev_pos].selected = true
    render

    while input.nil?
      input = @cursor.get_input
      system('clear')

      @board[prev_pos].selected = false
      @board[@cursor.cursor_pos].selected = true
      prev_pos = @cursor.cursor_pos
      render
    end
    system('clear')
    input
  end
end
