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
    prev_pos = @cursor.cursor_pos
    @board[prev_pos] = "#{@board[prev_pos]}".colorize(:background => :light_cyan)
    render
    while input.nil?
      input = @cursor.get_input
      @board[prev_pos] = "#{@board[prev_pos]}".colorize(:background => :white)
      @board[@cursor.cursor_pos] = "#{@board[@cursor.cursor_pos]}".colorize(:background => :light_cyan)
      prev_pos = @cursor.cursor_pos
      render
    end

    from = input
    input = nil

    while input.nil?
      input = @cursor.get_input
      @board[prev_pos] = "#{@board[prev_pos]}".colorize(:background => :white)
      @board[@cursor.cursor_pos] = "#{@board[@cursor.cursor_pos]}".colorize(:background => :light_cyan)
      prev_pos = @cursor.cursor_pos
      render
    end

    to = input
    @board.move_piece(from, to)
    render
    nil
  end
end
