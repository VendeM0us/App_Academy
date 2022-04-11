require_relative 'tile'
require 'colorize'

class Board
    def initialize
        @board = Array.new(9) { Array.new(9) }
    end

    def from_file(file_name)
        file = File.readlines("puzzles/" + file_name, chomp: true)

        file.each.with_index do |row, idx_1|
            row.each_char.with_index do |tile, idx_2|
                @board[idx_1][idx_2] = Tile.new(tile.to_i)
            end
        end
    end

    def render
        puts "  #{(1..9).to_a.map {|n| n.to_s.underline}.join(' ') } ".colorize(:background => :black)
        @board.each.with_index do |row, i|

            design = row.map do |tile|
                tile.to_s
            end

            puts "#{i + 1}|#{design.join('|')}|".colorize(:background => :black)
        end
    end

    def [](pos)
        idx_1, idx_2 = pos
        @board[idx_1][idx_2]
    end

    def []=(pos, val)
        idx_1, idx_2 = pos
        @board[idx_1][idx_2].value = val
    end

    def update_tile_val(pos, val)
        self[pos] = val unless self[pos].given?
    end

    def solved_row?
        @board.all? do |row|
            check = row.reject { |tile| tile.value == 0 }
            check.map(&:value).uniq.count == 9
        end
    end

    def solved_column?
        @board.transpose.all? do |column|
            check = column.reject { |tile| tile.value == 0}
            check.map(&:value).uniq.count == 9
        end
    end

    def get_3_by_3
        each_threes = []

        @board.each_slice(3) do |strips|
            strips.transpose.each_slice(3) do |threes|
                each_threes.concat(threes)
            end
        end

        each_threes.each_slice(3).map { |three_by_3| three_by_3.flatten }
    end

    def solved_3_by_3?
        self.get_3_by_3.all? do |three_by_3|
            check = three_by_3.reject { |tile| tile.value == 0 }
            check.map(&:value).uniq.count == 9
        end
    end

    def solved?
        self.solved_row? && self.solved_column? && self.solved_3_by_3?
    end
end