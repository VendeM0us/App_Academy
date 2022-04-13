require_relative "board"
require "byebug"

class InteractiveBoard
    attr_reader :board, :board_hidden

    def initialize
        @board = Board.new
        @board.seed_bombs
        @board_hidden = Array.new(9) { Array.new(9, "*") }
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

    def lose?(pos)
        # :B means the square has bomb
        board[pos] == :B
    end

    def win?
        # if hidden squares are exactly 10, that means it hasn't touched hidden 10 bombs, so player wins
        hidden = 0

        board_hidden.each do |rows|
            rows.each { |square| hidden += 1 if square == "*" }
        end

        hidden == 10
    end

    def fringe(pos)
        fringe_count = board.count_fringes(pos)
        unless fringe_count == 0
            self[pos] = fringe_count.to_s 
        end
    end

    def flag(pos)
        self[pos] = :F
    end

    def valid_pos?(pos)
        # pass position validity in string state first before converting them to integers
        idx_1, idx_2 = pos
        valid_idx = ('0'..'8').to_a
        valid_idx.include?(idx_1) && valid_idx.include?(idx_2)
    end

    def get_neighbors(pos)
        board.get_neighbors(pos)
    end
end