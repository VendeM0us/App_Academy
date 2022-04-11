require_relative "board"
require_relative "human_player"
require_relative "computer_player"

class Game
    def initialize(board_size, players)
        @board = Board.new(board_size)
        @players = []
        players.each do |mark, is_computer_player|
            if is_computer_player == true
                @players << ComputerPlayer.new(mark)
            else
                @players << HumanPlayer.new(mark)
            end
        end
        @current_player = @players[0]
    end

    def switch_turn
        @players.rotate!(1)
        @current_player = @players[0]
        @current_player
    end

    def play
        until !@board.empty_positions?
            system("clear")
            legal_positions = @board.legal_positions
            @board.print
            pos = @current_player.get_position(legal_positions)
            @board.place_mark(pos, @current_player.mark)

            sleep(1)
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