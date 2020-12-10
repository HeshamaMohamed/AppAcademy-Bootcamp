class HumanPlayer 

    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        p "Player " + @mark.to_s + " Please enter 2 values representing a position in the format 'row col'"
        pos = gets.chomp
        pos = pos.split(" ")
        if pos.count !=2 || pos.any? { |p| !p.to_i }
            raise "wrong position format, please enter 2 numbers separated by a single space"
        elsif   !legal_positions.include?( [pos[0].to_i, pos[1].to_i] )
            p pos.to_s + "is not a legal position"
        else
            return pos
            # puts mark.to_s
        end
    end

end