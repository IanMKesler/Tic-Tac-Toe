class Game
  require_relative "player"
  require_relative "board"

  def initialize
    puts "Initializing Game"
    @board = Board.new
    @p1 = Player.new("X")
    @p2 = Player.new("O")

    @p1.turn = true
    @symbol = "X"
  end

  def play
    turn = 1
    game_end = false
    win = false
    stalemate = false
    until game_end
      round
      won = false
      won = win?(@symbol)
      stalemated = (turn == 9 && !won)
      puts "#{@symbol} wins!" if won
      puts "Stalemate" if stalemated
      game_end = won || stalemated
      turn += 1
      flip_turns
      flip_symbol
    end
    @board.show
  end

  private

  def round
    position = get_move(@symbol)
    check = check?(position)
    until check
      puts "Please choose an open space"
      position = get_move(@symbol)
      check = check?(position)
    end
    @board.draw(position[0], position[1], @symbol)
  end

  def get_move(symbol)
    regexp = /[1-3],[1-3]/
    @board.show
    puts "#{@symbol}: Choose row and column"
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

  def flip_turns
    @p1.turn = !(@p1.turn)
    @p2.turn = !(@p2.turn)
  end

  def flip_symbol
    @symbol = @p1.turn ? @p1.symbol : @p2.symbol
  end

  def win?(symbol)
    case
    when @board.show(0, 1) == @symbol
      return true if (@board.show(0, 0) == @symbol && @board.show(0, 2) == @symbol) || (@board.show(1, 1) == @symbol && @board.show(2, 1) == @symbol)
    when @board.show(1, 0) == @symbol
      return true if (@board.show(0, 0) == @symbol && @board.show(2, 0) == @symbol) || (@board.show(1, 1) == @symbol && @board.show(1, 2) == @symbol)
    when @board.show(1, 2) == @symbol
      return true if (@board.show(0, 2) == @symbol && @board.show(2, 2) == @symbol)
    when @board.show(2, 1) == @symbol
      return true if (@board.show(2, 0) == @symbol && @board.show(2, 2) == @symbol)
    when @board.show(1, 1) == @symbol
      return true if (@board.show(0, 0) == @symbol && @board.show(2, 2) == @symbol) || (@board.show(0, 2) == @symbol && @board.show(2, 0) == @symbol)
    else
      return false
    end
  end
end
