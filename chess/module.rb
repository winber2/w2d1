module Stepable
  def moves
    move_diff
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
    [[1,0], [-1,0], [0,1],[0,-1]]
  end

  def diagonal_dirs
    [[1,1],[1,-1],[-1,1],[-1,-1]]
  end

  def grow_unblocked_moves_in_dir(dx, dy)
    move_arr = []
    move = [@pos[0] + dx, @pos[1] + dy]
    while valid(move) && @board[move] == Nullpiece.instance
      move_arr << move
      move = [move[0] + dx, move[1] + dy]
    end
    move_arr << move if valid(move) && @board[move].color != @color
    move_arr
  end


  def valid(move)
    move.all? { |idx| idx.between?(0,7) }
  end

end
