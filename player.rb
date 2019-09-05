class Player
  attr_accessor :turn, :win
  attr_reader :sym 

  def initialize(sym)
    @sym = sym
    @turn = false
    @win = false
  end
end
