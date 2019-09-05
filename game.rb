class Game
  require_relative "player"
  require_relative "board"

  def initialize
    puts "Initializing Game"
    @board = Board.new
    @p1 = Player.new("X")
    @p2 = Player.new("O")

    @p1.turn = true
    @sym = "X"
  end

  def play
    turn = 1
    check = false
    win = false
    stalemate = false
    until check
      round
      won = false
      won = win?(@sym)
      stalemated = (turn == 9 && !won)
      puts "#{@sym} wins!" if won
      puts "Stalemate" if stalemated
      check = won || stalemated
      turn += 1
      flipTurns
      flipSym
    end
    @board.show
  end

  private

  def round
    position = getMove(@sym)
    check = check?(position)
    until check
      puts "Please choose an open space"
      position = getMove(@sym)
      check = check?(position)
    end
    @board.draw(position[0], position[1], @sym)
  end

  def getMove(sym)
    regexp = /[1-3],[1-3]/
    @board.show
    puts "#{@sym}: Choose row and column"
    error = true
    while error
      position = gets.strip
      if position.match(regexp)
        position = position.split(',')
        error = false
      else
        puts "Please input the row and column. Ex: 1,3 for row 1 and column 3"
      end
    end
    position.map! { |x| x.to_i }
    position
  end

  def check?(position)
    @board.show(position[0], position[1]) == "0" ? true : false
  end

  def flipTurns
    @p1.turn = !(@p1.turn)
    @p2.turn = !(@p2.turn)
  end

  def flipSym
    @sym = @p1.turn ? @p1.sym : @p2.sym
  end

  def win?(sym)
    case
    when @board.show(0, 1) == @sym
      return true if (@board.show(0, 0) == @sym && @board.show(0, 2) == @sym) || (@board.show(1, 1) == @sym && @board.show(2, 1) == @sym)
    when @board.show(1, 0) == @sym
      return true if (@board.show(0, 0) == @sym && @board.show(2, 0) == @sym) || (@board.show(1, 1) == @sym && @board.show(1, 2) == @sym)
    when @board.show(1, 2) == @sym
      return true if (@board.show(0, 2) == @sym && @board.show(2, 2) == @sym)
    when @board.show(2, 1) == @sym
      return true if (@board.show(2, 0) == @sym && @board.show(2, 2) == @sym)
    when @board.show(1, 1) == @sym
      return true if (@board.show(0, 0) == @sym && @board.show(2, 2) == @sym) || (@board.show(0, 2) == @sym && @board.show(2, 0) == @sym)
    else
      return false
    end
  end
end
