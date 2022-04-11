class Board
    def initialize(n)
        @grid = Array.new(n) { Array.new(n, '_') }
    end

    def print
        @grid.each do |row|
            puts row.join(" ")
        end
    end

    def valid?(position)
        row, column = position
        (0...@grid.length).to_a.include?(row) && (0...@grid.length).to_a.include?(column)
    end

    def empty?(position)
        row, column = position
        @grid[row][column] == '_'
    end

    def place_mark(position, mark)
        if self.valid?(position) && self.empty?(position)
            row, column = position
            @grid[row][column] = mark
        else
            raise "Invalid position or the position is empty"
        end
    end

    def win_row?(mark)
        check_row = @grid
        return true if check_row.any? { |line| line.all? { |pos| pos == mark } }
        false
    end

    def win_col?(mark)
        check_col = @grid.transpose
        return true if check_col.any? { |line| line.all? { |pos| pos == mark } }
        false
    end

    def win_diagonal?(mark)
        col_left = 0 #left column index
        col_right = -1 #right column index
        diag_1 = true
        diag_2 = true

        @grid.each do |row|
            diag_1 = false if row[col_left] != mark
            diag_2 = false if row[col_right] != mark
            col_left += 1
            col_right -= 1
        end

        return true if diag_1 || diag_2
        false
    end

    def win?(mark)
        win_row?(mark) || win_col?(mark) || win_diagonal?(mark)
    end

    def empty_positions?
        @grid.any? { |row| row.any? { |pos| pos == '_' } }
    end
end