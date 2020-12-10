class Board

    def initialize()
        @grid = Array.new(8) { Array.new(8) {0}}
        # self.render
    end
    def render
       @grid.each { |row| p row } 
    end
    
end