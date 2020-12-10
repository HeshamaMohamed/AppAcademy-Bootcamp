


class Board

    # attr_reader :grid

    def initialize(n)
        @grid = Array.new(n) { Array.new(n) {"_"}}
        self.print
    end

    def valid?(pos)
        row= pos[0].to_i
        col= pos[1].to_i
        (0...@grid.length).member?(row) && (0...@grid.length).member?(col)
    end

    def empty?(pos)
        row= pos[0].to_i
        col= pos[1].to_i
        @grid[row][col] == "_"
    end
    def place_mark(pos, mark)
        if !self.valid?(pos) || !self.empty?(pos)
            raise "invalid mark or not empty"
        else
            row= pos[0].to_i
            col= pos[1].to_i
            @grid[row][col] = mark
        end
        # self.print
        # self.win?(mark)
    end
    
    def print
        @grid.each { |row| p row}
    end

    def win_row?(mark)
        @grid.any? { |row| row.all? { |col| col == mark     } }
    end

    def win_col?(mark)
        @grid.transpose.any? { |row| row.all? { |col| col == mark     } }
    end

    def win_diagonal?(mark)
        (0...@grid.length).all? { |i| @grid[i][i] == mark} || (0...@grid.length).all? { |i| @grid[i][@grid.length - 1- i] == mark}
    end

    def win?(mark)
        if win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
            puts mark.to_s + " IS THE WINNER!"
            return true
        else
            false
        end
    end

    def empty_positions?
        length = @grid.length-1
        @grid.any? do |row|
            row.any? { |col| col== "_" }
        end
    end

    def legal_positions
        arr = []
        length = @grid.length-1
        (0..length).each do |row|
            (0..length).each do |col|
               arr << [row,col] if @grid[row][col] == "_"
            end
        end
        arr 
    end


end
