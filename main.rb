require_relative "game"

game = Game.new
game.board.draw(1,3,"X")
game.board.draw(2,2,"X")
game.board.draw(3,1,"X")
game.send(:win?, "X")