require_relative 'board'
require_relative 'computer_player'
require_relative 'human_player'

class Game
    def initialize(player)
        @board = Board.new
        @previous_guess = ''
        @number_of_attempts = 0
        @player = player
    end

    def compare_cards(current_guess)
        self.render_board

        if @previous_guess.empty?
            @previous_guess = current_guess
            @player.previous_guess = @previous_guess
        else
            if @board[current_guess] == @board[@previous_guess]
                puts 'It\'s a match!'

                @board.reveal(current_guess)
                @board.reveal(@previous_guess)

                @number_of_attempts += 1
                @previous_guess = ''
                @player.previous_guess = @previous_guess
            else
                puts 'Try again!'

                @board[current_guess].hide
                @board[@previous_guess].hide

                @number_of_attempts += 1
                @previous_guess = ''
                @player.previous_guess = @previous_guess
            end
        end

        sleep(1.5)
    end

    def set_ai_data(guess)
        val = @board.reveal(guess)

        pos_1 = @player.known_cards.key(val)
        pos_2 = guess
        @player.receive_match(pos_1, pos_2) if @player.known_cards.has_value?(val)

        @player.receive_revealed_card(guess, val)
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
            @player.cards = @board.get_face_values
            self.display_attempts

            guess = @player.get_input

            unless self.repeated_guess?(guess)
                @board.reveal(guess)
                self.set_ai_data(guess)
                self.compare_cards(guess)
            end
        end

        self.display_victory
    end
end

if __FILE__ == $PROGRAM_NAME
    player = ComputerPlayer.new
    game = Game.new(player)
    game.play
end