class Board
    attr_reader :grid

    def initialize
        # :N for no bomb
        @grid = Array.new(9) { Array.new(9, :N)}
    end

    alias_method :board, :grid

    def count_bombs
        count = 0
        bombs = grid.each do |rows|
            rows.each { |square| count += 1 if square == :B }
        end
        count
    end

    def seed_bombs
        until self.count_bombs == 10
            idx_1 = rand(0..8)
            idx_2 = rand(0..8)
            pos = [idx_1, idx_2]

            self[pos] = :B
        end
    end

    def [](pos)
        x, y = pos
        board[x][y]
    end

    def []=(pos, val)
        x, y = pos
        board[x][y] = val
    end

    def get_neighbors(pos)
        x, y = pos
        [
            [x + 1, y], [x - 1, y],
            [x, y + 1], [x, y - 1],
            [x + 1 ,y + 1], [x + 1, y - 1],
            [x - 1, y - 1], [x - 1, y + 1]
        ].select do |index|
            idx_1, idx_2 = index
            idx_1.between?(0, 8) && idx_2.between?(0, 8)
        end
    end

    def count_fringes(pos)
        self.get_neighbors(pos).count do |neighbor|
            self[neighbor] == :B
        end
    end 
end