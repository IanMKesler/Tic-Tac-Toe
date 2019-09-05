class Board
  def initialize
    @board = [['0', '0', '0'],['0', '0', '0'],['0', '0', '0']]
  end

  def draw(r, c, sym)
    @board[r-1][c-1] = sym
  end

  def show(r = nil, c = nil)
    r && c ? @board[r-1][c-1] : @board.each {|r| puts r.join}
  end
end