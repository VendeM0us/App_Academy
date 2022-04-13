require_relative "interactive_board"

class MineSweeper
    attr_reader :board

    def initialize
        @board = InteractiveBoard.new
    end

    def take_turn
        board.render
    end
end