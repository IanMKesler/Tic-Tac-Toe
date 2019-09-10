class Player
  attr_accessor :turn, :win
  attr_reader :symbol 

  def initialize(symbol)
    @symbol = symbol
    @turn = false
    @win = false
  end
end
