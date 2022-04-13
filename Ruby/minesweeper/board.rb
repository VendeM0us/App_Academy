class Board
    attr_writer :grid

    def initialize
        @grid = Array.new(9) { Array.new(9) }
    end

    def seed_bombs
        @grid.map! do |rows|
            rows.map! do |square|
                mine = [:N, :B]
                square = mine.sample
            end
        end
    end

    def [](pos)
        x, y = pos
        @grid[x][y]
    end
end