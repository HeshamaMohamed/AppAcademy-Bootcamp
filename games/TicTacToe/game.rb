require_relative "./Board.rb"
require_relative "./Human_Player.rb"
require_relative "./Computer_player.rb"
class Game
    def initialize(n, players)
        @players = []
        players.each do |mark, computer|
            if computer
                @players << ComputerPlayer.new(mark)
            else
                @players << HumanPlayer.new(mark)
            end
        end
        @board = Board.new(n)
        @current_player = @players[0]
    end


    def switch_turn
        @players.rotate!
        @current_player = @players[0]
    end

    def play
        while @board.empty_positions?
            pos = @current_player.get_position(@board.legal_positions)
            mark = @current_player.mark
            @board.place_mark(pos, mark)
            @board.print
            if @board.win?(mark)
                return 
            else
                self.switch_turn
            end
            break if !@board.empty_positions?
        end
        puts "Draw!" if !@board.empty_positions?
        return
    end


end