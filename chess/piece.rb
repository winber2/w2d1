require_relative "module"
require 'singleton'

class Piece
  attr_reader :symbol, :pos, :board, :color
  COLORS = {:white => :red, :black => :black}
  def initialize(color, pos, board, symbol = nil)
    @symbol = symbol
    @board = board
    @color = color
    @pos = pos
  end

  def to_s
    empty? ? "-" : "#{@symbol[0].upcase.colorize(:color => COLORS[@color], :background => :yellow)}"
  end

  def empty?
    @symbol.nil?
  end

  def valid_moves
    possible_moves = []
    moves.each do |move|
      possible_moves << @pos.map.with_index { |idx| @pos[idx] + move[idx]}
    end

    possible_moves
  end

  def move_into_check(to_pos)
    to_pos.all? { |el| el.between?(0, 7)}
  end
end

class Pawn < Piece
  def initialize(color, pos, board, symbol = :pawn)
    super
  end

  def moves
    forward_steps + side_attacks
  end

  protected

  def start_row?
    @color == :white ? @pos[0] == 6 : @pos[0] == 1
  end

  def forward_dir
    @color == :white ? [1, 0] : [-1, 0]
  end

  def forward_steps
    if start_row?
      [forward_dir, forward_dir.map { |el| el * 2 }]
    else
      [forward_dir]
    end
  end

  def side_attacks
    [[forward_dir[0], forward_dir[1] + 1], [forward_dir[0], forward_dir[1] - 1]]
  end

end

class King < Piece
  include Stepable

  def initialize(color, pos, board, symbol = :king)
    super
  end

  protected

  def move_diff
    move_arr = []
    (-1..1).each do |row|
      (-1..1).each do |col|
        next if row == 0 && col == 0
        move_arr << [@pos[0] + row, @pos[1] + col]
      end
    end

    move_arr
  end

end


class Knight < Piece
  include Stepable

  KNIGHT_MOVES = [
    [2, 1],
    [2, -1],
    [-2, 1],
    [-2, -1],
    [1, 2],
    [1, -2],
    [-1, 2],
    [-1, -2]
  ]
  def initialize(color, pos, board, symbol = :night)
    super
  end

  protected

  def move_diff
    move_arr = []
    KNIGHT_MOVES.each do |move|
      move_arr << [@pos[0] + move[0], @pos[1] + move[1]]
    end

    move_arr
  end

end


class Bishop < Piece
  include Slideable

  def initialize(color, pos, board, symbol = :bishop)
    super
  end

  protected

  def move_dirs
    move_arr = []

    diagonal_dirs.each do |dir|
      move_arr << grow_unblocked_moves_in_dir(dir[0], dir[1])
    end

    move_arr
  end

end

class Rook < Piece
  include Slideable

  def initialize(color, pos, board, symbol = :rook)
    super
  end

  protected

  def move_dirs
    move_arr = []

    horizontal_dirs.each do |dir|
      move_arr << grow_unblocked_moves_in_dir(dir[0], dir[1])
    end

    move_arr
  end
end

class Queen < Piece
  include Slideable

  def initialize(color, pos, board, symbol = :queen)
    super
  end

  protected

  def move_dirs
    move_arr = []

    diagonal_dirs.each do |dir|
      move_arr << grow_unblocked_moves_in_dir(dir[0], dir[1])
    end

    horizontal_dirs.each do |dir|
      move_arr << grow_unblocked_moves_in_dir(dir[0], dir[1])
    end

    move_arr
  end
end

class Nullpiece < Piece
  include Singleton

  def initialize
    @symbol = nil
    @color = nil
  end

  def moves
    []
  end
end
