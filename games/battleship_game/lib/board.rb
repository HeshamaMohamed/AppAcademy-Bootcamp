class Board
    attr_reader :size
    
    def self.print_grid(gridArr)
        gridArr.each do |row| 
            puts row.join(" ")
        end
    end
    
    def initialize(n)
        @grid = Array.new(n) {Array.new(n,:N)}
        @size = n*n
    end

    def [](pos)
        @grid[pos[0]][pos[1]]
    end
    def []=(pos,val)
        @grid[pos[0]][pos[1]] = val
    end

    def num_ships
        @grid.count {|(r,c)| r == :S || c == :S }
    end

    def attack(pos)
        if self[pos] == :S
            self[pos] = :H
            p   "you sunk my battleship!"
            return true
        else
            self[pos] = :X
            return false
        end
    end

    def place_random_ships
        length = @grid.flatten.length/4
        listPos = []
        pos = []
        0..length.times do 
            r = rand(0...@grid.length)
            c = rand(0...@grid.length)
            pos = [r,c]
            while listPos.include?(pos)
                r = rand(0...@grid.length)
                c = rand(0...@grid.length)
                pos = [r,c]
            end
            listPos << pos
            self[pos] = :S
        end

    end

    def hidden_ships_grid
        return @grid.map do |r| 
            r.map do |el|
                if el == :S  
                    el= :N 
                else
                    el
                end
            end
        end
    end


    def cheat
        Board::print_grid(@grid)
    end
    def print
        Board::print_grid(self.hidden_ships_grid)
    end

end
