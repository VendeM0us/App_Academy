require_relative 'board'

class Game
    def initialize
        @board = Board.new
        @previous_guess = ''
        @number_of_attempts = 0
    end

    def compare_cards(current_guess)
        self.render_board

        if @previous_guess.empty?
            @previous_guess = current_guess
        else
            if @board[current_guess] == @board[@previous_guess]
                puts 'It\'s a match!'

                @board.reveal(current_guess)
                @board.reveal(@previous_guess)

                @number_of_attempts += 1
                @previous_guess = ''
            else
                puts 'Try again!'

                @board[current_guess].hide
                @board[@previous_guess].hide

                @number_of_attempts += 1
                @previous_guess = ''
            end
        end

        sleep(1.5)
    end

    def get_input
        puts 'Please enter the position of the card you\'d like to flip (e.g \'2 3\')'
        print '> '
        gets.chomp.split.map(&:to_i)
    end

    def repeated_guess?(guessed_pos)
        if @board[guessed_pos].face_value != ' '
            return true
        end

        false
    end

    def display_welcome
        system('clear')
        puts 'Welcome to Memory Game!'
        sleep(2)
    end

    def display_attempts
        puts "Number of attempts: #{@number_of_attempts}"
    end

    def display_victory
        self.render_board
        self.display_attempts
        puts "\nCONGRATULATIONS!"
    end

    def render_board
        system('clear')
        @board.render
    end

    def play
        self.display_welcome
        @board.populate

        until @board.won?
            self.render_board
            self.display_attempts

            guess = self.get_input

            unless self.repeated_guess?(guess)
                @board.reveal(guess)
                self.compare_cards(guess)
            end
        end

        self.display_victory
    end
end

if __FILE__ == $PROGRAM_NAME
    game = Game.new
    game.play
end