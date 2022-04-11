require_relative 'board'

class Game
    def initialize(txt_file)
        @board = Board.new
        @board.from_file(txt_file)
    end

    def prompt
        puts "Enter a grid position and a value (format: <row> <column> <value>, e.g. 1 2 8)"
        print '> '
    end

    def valid_pos?(pos)
        valid_index = ('1'..'9').to_a
        idx_1, idx_2 = pos
        is_valid_indeces = valid_index.include?(idx_1) && valid_index.include?(idx_2)
        is_valid_indeces && pos.count == 2
    end

    def valid_val?(val)
        valids = ('0'..'9').to_a
        valids.include? val
    end

    def get_input
        while true
            input = gets.chomp.split
            idx_1, idx_2, val = input

            pos = [idx_1, idx_2]
            val = val

            if input.count == 3 && self.valid_pos?(pos) && self.valid_val?(val)
                @board.update_tile_val(pos.map { |idx| idx.to_i - 1 }, val.to_i)
                return
            else
                self.render_board
                puts "Invalid input! Try again."
                self.prompt
            end
        end
    end

    def welcome_message
        system('clear')
        puts 'WELCOME TO GAME OF SUDOKU!'
        sleep(2)
    end

    def render_board
        system('clear')
        @board.render
    end

    def play
        self.welcome_message

        until @board.solved?
            self.render_board
            self.prompt
            self.get_input
        end

        self.render_board
        puts "\nCONGRATULATIONS!"
    end
end

if __FILE__ == $PROGRAM_NAME
    puts "Enter file name (e.g. sudoku1)"
    print '> '
    file_name = gets.chomp
    sudoku = Game.new(file_name + '.txt')
    sudoku.play
end