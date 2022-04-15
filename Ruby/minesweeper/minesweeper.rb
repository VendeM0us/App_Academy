require_relative "interactive_board"

class MineSweeper
    attr_reader :board

    def initialize
        @board = InteractiveBoard.new
    end

    def chain(pos)
        board.checked_neighbors << pos
        return [pos] if board.has_fringe?(pos)

        chains = [pos]

        board.get_neighbors(pos).each do |neighbor|
            unless board.checked_neighbors.include?(neighbor)
                chains.concat(chain(neighbor))
            end
        end

        chains
    end

    def valid_pos?(pos)
        # pass position validity in string state first before converting them to integer
        pos = pos.split(",")

        idx_1, idx_2 = pos
        valid_idx = ('0'..'8').to_a
        valid_idx.include?(idx_1) && valid_idx.include?(idx_2)
    end

    def parse_pos(pos)
        pos.split(",").map { |ch| Integer(ch) }
    end

    def valid_command?(ch)
        commands = ['r', 'f']
        commands.include?(ch)
    end

    def valid_input?(array)
        array.length == 2
    end

    def prompt
        puts "Enter a command and a pos (r for reveal and f for flag)."
        puts "Example: r 3,4"
        print "> "
    end

    def show_error
        system("clear")
        board.render
        puts "Invalid Input"
        self.prompt
    end

    def reveal(pos)
        unless board.flagged?(pos)
            if board.bombed?(pos)
                board.show_bombed
                return
            end

            chains = self.chain(pos)

            chains.each do |square|
                board.reveal(square) unless board.flagged?(square)
            end
        end
    end

    def take_turn
        system("clear")
        board.render
        self.prompt

        valid_input = false

        while !valid_input
            input = gets.chomp.split(" ")

            if valid_input?(input)
                command, pos = input
                if self.valid_pos?(pos) && self.valid_command?(command)
                    valid_input = true

                    pos = self.parse_pos(pos)
                    command == "r" ? self.reveal(pos) : board.flag(pos)
                else
                    self.show_error
                end
            else
                self.show_error
            end
        end
    end

    def play
        puts "WELCOME TO MINESWEEPER TERMINAL EDITION!!"
        sleep(2)

        self.take_turn until board.win? || board.lose?

        if board.win?
            system("clear")
            board.render
            puts "YOU WIN!! CONGRATULATIONS!"
        else
            puts "YOU LOSE"
        end
    end

    def save_game(save)
        File.open("saves/#{save}.yaml", "w") { |file| file.write(board.to_yaml) }
    end
end

game = MineSweeper.new
game.play