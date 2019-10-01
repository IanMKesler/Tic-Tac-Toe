require_relative "../board"
require_relative "../game"
require_relative "../player"

describe "Game" do
    describe "win?" do
        it "three across top" do
            game = Game.new
            game.board.draw(1,1,"X")
            game.board.draw(1,2,"X")
            game.board.draw(1,3,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three across middle" do
            game = Game.new
            game.board.draw(2,1,"X")
            game.board.draw(2,2,"X")
            game.board.draw(2,3,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three across bottom" do
            game = Game.new
            game.board.draw(3,1,"X")
            game.board.draw(3,2,"X")
            game.board.draw(3,3,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three down left" do
            game = Game.new
            game.board.draw(1,1,"X")
            game.board.draw(2,1,"X")
            game.board.draw(3,1,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three down middle" do
            game = Game.new
            game.board.draw(1,2,"X")
            game.board.draw(2,2,"X")
            game.board.draw(3,2,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three down right" do
            game = Game.new
            game.board.draw(1,3,"X")
            game.board.draw(2,3,"X")
            game.board.draw(3,3,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three diagonal left" do
            game = Game.new
            game.board.draw(1,1,"X")
            game.board.draw(2,2,"X")
            game.board.draw(3,3,"X")
            expect(game.send(:win?, "X")).to be true
        end

        it "three diagonal right" do
            game = Game.new
            game.board.draw(1,3,"X")
            game.board.draw(2,2,"X")
            game.board.draw(3,1,"X")
            expect(game.send(:win?, "X")).to be true
        end
    end

    describe "get_move" do
        it "returns the selected position" do
            game = Game.new
            game.stub(:gets){ "1,1\n" }
            expect(game.send(:get_move, "X")).to eql([1,1])
        end

        it "handles incorrect inputs" do
            game = Game.new
            game.stub(:gets).and_return("0,0\n", "2,2\n")
            expect(game.send(:get_move, "X")).to eql([2,2])
        end
    end

    describe "check?" do
        it "returns true for valid positions" do
            game = Game.new
            game.board.draw(2,2,"O")
            game.board.draw(1,1,"X")
            expect(game.send(:check?, [3,3])).to be true
        end

        it "returns false for taken positions" do
            game = Game.new
            game.board.draw(1,2,"O")
            game.board.draw(1,1,"X")
            expect(game.send(:check?, [1,1])).to be false
        end
    end
end