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
    move = [@pos[0] + dx, @pos[1] + dy]
    while move_into_check(move)
      move_arr << move
      move = [move[0] + dx, move[1] + dy]
    end

    move_arr
  end


end
