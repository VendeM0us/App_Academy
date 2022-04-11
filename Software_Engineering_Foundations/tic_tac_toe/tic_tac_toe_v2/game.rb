require_relative "board"
require_relative "human_player"

class Game
    def initialize(board_size, *players)
        @board = Board.new(board_size)
        @players = players.map { |player| HumanPlayer.new(player) }
        @current_player = @players[0]
    end

    def switch_turn
        @players.rotate!(1)
        @current_player = @players[0]
        @current_player
    end

    def play
        until !@board.empty_positions?
            @board.print
            pos = @current_player.get_position
            @board.place_mark(pos, @current_player.mark)
            if @board.win?(@current_player.mark)
                @board.print
                puts "#{@current_player.mark} won!"
                return
            else
                self.switch_turn
            end
        end

        @board.print
        puts "Draw!"
    end
end