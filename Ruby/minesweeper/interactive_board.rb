require_relative "board"

class InteractiveBoard
    attr_reader :board, :board_hidden
    
    def initialize
        @board = Board.new
        @board.seed_bombs
        @board_hidden = Array.new(9) { Array.new(9) }
    end
end