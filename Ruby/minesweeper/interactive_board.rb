require_relative "board"
require "colorize"

class InteractiveBoard
    attr_reader :board, :board_hidden, :checked_neighbors

    def initialize
        @board = Board.new
        @board.seed_bombs
        @board_hidden = Array.new(9) { Array.new(9, "*") }
        @checked_neighbors = Array.new
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        board_hidden.each.with_index do |rows, i|
            puts "#{i} #{rows.join(" ")}"
        end
    end

    def [](pos)
        x, y = pos
        board_hidden[x][y]
    end

    def []=(pos, val)
        x, y = pos
        board_hidden[x][y] = val
    end

    def lose?
        # :B means the square has bomb
        board_hidden.any? do |rows|
            rows.any? { |square| square == "B".colorize(:red) }
        end
    end

    def win?
        # if hidden squares are exactly 10, that means it hasn't touched hidden 10 bombs, so player wins
        hidden = 0

        board_hidden.each do |rows|
            rows.each { |square| hidden += 1 if square == "*" || square == "F".colorize(:light_blue)}
        end

        hidden == 10
    end

    def reveal(pos)
        fringe_count = board.count_fringes(pos)
        unless fringe_count == 0
            self[pos] = fringe_count.to_s.colorize(:yellow) 
        else
            self[pos] = " "
        end
    end

    def flag(pos)
        if self[pos] == "F".colorize(:light_blue)
            self[pos] = "*"
        else
            self[pos] = "F".colorize(:light_blue) if self[pos] == "*"
        end
    end

    def flagged?(pos)
        self[pos] == "F".colorize(:light_blue)
    end

    def has_fringe?(pos)
        board.count_fringes(pos) > 0
    end

    def get_neighbors(pos)
        board.get_neighbors(pos)
    end

    def show_bombed
        board.grid.each.with_index do |rows, idx_1|
            rows.each.with_index do |square, idx_2|
                pos = [idx_1, idx_2]
                self[pos] = "B".colorize(:red) if square == :B
            end
        end

        system("clear")
        self.render
    end

    def bombed?(pos)
        board[pos] == :B
    end
end