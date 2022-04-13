require_relative "interactive_board"

class MineSweeper
    attr_reader :board

    def initialize
        @board = InteractiveBoard.new
    end

    def valid_pos?(pos)
        # pass position validity in string state first before converting them to integers
        pos = pos.split(",")
        return false if pos.length != 2

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

    def take_turn
        valid_input = false

        while !valid_input
            board.render
            puts "Enter a command and a pos (r for reveal and f for flag)."
            puts "Example: r 3,4"
            print "> "

            input = gets.chomp.split(" ")
            command, pos = input

            if self.valid_pos?(pos) && self.valid_command? && valid_input?(input)
                valid_input = true
            else
                system("clear")
                puts "Invalid Input"
            end
        end
    end
end