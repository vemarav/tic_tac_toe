module Board
  extend ActiveSupport::Concern

  # 0 | 1 | 2
  # 3 | 4 | 5
  # 6 | 7 | 8
  WIN_COMBINATIONS = [
    [0, 1, 2], [3, 4, 5], [6, 7, 8], # horizontal
    [0, 3, 6], [1, 4, 7], [2, 5, 8], # vertical
    [0, 4, 8], [2, 4, 6],
  ]

  def equals3(a, b, c)
    a != "" && a == b && b == c
  end

  def won?
    WIN_COMBINATIONS.each do |combination|
      if equals3 board[combination[0]], board[combination[1]], board[combination[2]]
        return board[combination[0]]
      end
    end

    unless board.include? ""
      return "Tie"
    end
  end
end
