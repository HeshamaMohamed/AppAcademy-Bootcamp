
class ComputerPlayer
    
    attr_reader :mark
    def initialize(mark_value)
        @mark = mark_value
    end 

    def get_position(legal_positions)
        # p "Player " + @mark.to_s + " Please enter 2 values representing a position in the format 'row col'"
        p legal_positions
        pos = legal_positions.sample
        # legal_positions.delete(pos)
        # loop do  
        #     pos = gets.chomp
        #     break if !legal_positions.include?(pos) 
        # end
        return pos
    end


end