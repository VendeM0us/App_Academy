require_relative "board"

class InteractiveBoard
    attr_reader :board, :board_hidden

    def initialize
        @board = Board.new
        @board.seed_bombs
        @board_hidden = Array.new(9) { Array.new(9, " ") }
    end

    def render
        puts "  #{(0..8).to_a.join(" ")}"
        board_hidden.each.with_index do |rows, i|
            puts "#{i} #{rows.join(" ")}"
        end
    end
end