require_relative "interactive_board"

class MineSweeper
    attr_reader :board

    def initialize
        @board = InteractiveBoard.new
    end

    def valid_pos?(pos)
        # pass position validity in string state first before converting them to integers
        idx_1, idx_2 = pos
        valid_idx = ('0'..'8').to_a
        valid_idx.include?(idx_1) && valid_idx.include?(idx_2)
    end

    def take_turn
        board.render

        command = nil
        pos = nil

        until board.valid_pos?(pos) && 
    end
end