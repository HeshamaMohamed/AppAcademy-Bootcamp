require_relative "board"
require_relative "player"

class Battleship

    attr_reader :board, :player

    def initialize(length)
        @player = Player.new()
        @board = Board.new(length)
        @remaining_misses = length*length/2
    end

    
    def start_game
        @board.place_random_ships
        p @board.size * 0.25
        @board.print
    end

    def lose?
        if @remaining_misses < 1
            p 'you lose' 
            return true
        else
            return false
        end
    end

    def win?
        if @board.num_ships <1
            p "you win"
            return true
        else
            return false
        end
    end

    def game_over?
        return true if win? || lose?
        return false
    end

    def turn
        move = @player.get_move
        p @remaining_misses -=1 if !@board.attack(move)
        p @board.print
    end
end
