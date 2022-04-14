require_relative "interactive_board"
require "byebug"

class MineSweeper
    attr_reader :board

    def initialize
        @board = InteractiveBoard.new
        @checked_neighbors = Array.new
    end

    def chain(pos)
        # debugger
        @checked_neighbors << pos
        return [pos] if board.has_fringe?(pos)

        chains = [pos]

        board.get_neighbors(pos).each do |neighbor|
            unless @checked_neighbors.include?(neighbor)
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

    def take_turn
        @checked_neighbors = []
        board.render
        self.prompt

        valid_input = false

        while !valid_input
            input = gets.chomp.split(" ")

            if valid_input?(input)
                command, pos = input
                if self.valid_pos?(pos) && self.valid_command?(command)
                    valid_input = true
                else
                    self.show_error
                end
            else
                self.show_error
            end
        end
    end
end