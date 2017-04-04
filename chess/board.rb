require_relative "piece"
require "colorize"
require 'byebug'


class Board
  attr_reader :grid

  def initialize(grid = Board.create_grid)
    @grid = grid
    self.populate_grid
  end

  def [](pos)
    row, col = pos
    @grid[row][col]
  end

  def []=(pos, val)
    row, col = pos
    @grid[row][col] = val
  end

  def self.create_grid
    Array.new(8) { Array.new(8)}
  end

  def populate_grid
    @grid.each_with_index do |r, row|
      r.each_index do |col|
        pos = [row, col]
        place_piece(pos)
      end
    end
  end

  def place_piece(pos)
    if pos == [0,0] || pos == [0,7]
      self[pos] = Rook.new(:black, pos, @grid)
    elsif pos == [7,0] || pos == [7,7]
      self[pos] = Rook.new(:white, pos, @grid)

    elsif pos == [0,1] || pos == [0,6]
      self[pos] = Knight.new(:black, pos, @grid)
    elsif pos == [7,1] || pos == [7,6]
      self[pos] = Knight.new(:white, pos, @grid)

    elsif pos == [0,2] || pos == [0,5]
      self[pos] = Bishop.new(:black, pos, @grid)
    elsif pos == [7,2] || pos == [7,5]
      self[pos] = Bishop.new(:white, pos, @grid)

    elsif pos == [0,3]
      self[pos] = Queen.new(:black, pos, @grid)
    elsif pos == [7,3]
      self[pos] = Queen.new(:white, pos, @grid)

    elsif pos == [0,4]
      self[pos] = King.new(:black, pos, @grid)
    elsif pos == [7,4]
      self[pos] = King.new(:white, pos, @grid)

    elsif pos[0] == 1
      self[pos] = Pawn.new(:black, pos, @grid)
    elsif pos[0] == 6
      self[pos] = Pawn.new(:white, pos, @grid)

    else
      self[pos] = Nullpiece.instance
    end
  end

  def dup
    new_grid = []
    @grid.each do |row|
      new_grid << row.dup
    end

    Board.new(new_grid)
  end

  def move_piece(from_pos, to_pos)
    if self[from_pos] == Nullpiece.instance
      raise "There is no piece"
    else

    end

    self[to_pos] = self[from_pos]
    self[from_pos] = Nullpiece.instance
  end

end
