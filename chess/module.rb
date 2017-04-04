module Stepable
  def moves
    moves_diff
  end

  private

  def move_diff

  end
end


module Slideable
  def moves
    move_dirs
  end

  private

  def move_dirs

  end

  def horizontal_dirs
    [[1,0], [-1, 0], [0,1],[0,-1]]
  end

  def diagonal_dirs
    [[1,1],[1,-1],[-1,1],[-1,-1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    move_arr = []
    move = [@pos[0], @pos[1]]
    while valid(move)
      move = [move[0] + dx, move[1] + dy]
      move_arr << move
    end

    move_arr.select {|move| @board[move] == Nullpiece.instance || @board[move].color != @color}
  end

  def valid(move)
    move.all? {|idx| idx.between?(0,7) && @board[move] != Nullpiece.instance }
  end

end
