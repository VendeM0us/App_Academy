require 'set'
require_relative 'player'

class Game
    ALPHABET = ('a'..'z').to_a
    MAX_LOSS_COUNT = 5

    def initialize(player_1, player_2)
        @players = [player_1, player_2]
        @dictionary = Set.new File.readlines('dictionary.txt', chomp: true)
        @fragment = ""
        @losses = Hash.new { |player, losses| player[losses] = 0 }
    end

    def current_player
        @players[0]
    end

    def next_player!
        @players.rotate!
    end

    def take_turn(player) 
        self.check_if_no_more_words_to_build
        
        valid_turn = false

        while !valid_turn
            puts "#{player.name}, enter a letter: "
            player.guess = gets.chomp.downcase
            possible_fragment = @fragment + player.guess

            if self.valid_play?(possible_fragment)
                valid_turn = true
                @fragment = possible_fragment
                return
            end

            player.alert_invalid_guess unless self.check_if_no_more_words_to_build
        end
    end

    def valid_play?(possible_fragment)
        @dictionary.any? { |word| word.include?(possible_fragment) }
    end

    def check_if_no_more_words_to_build
        check = ALPHABET.all? do |letter|
            possible_fragment = @fragment + letter
            @dictionary.none? { |word| word.include?(possible_fragment) }
        end

        if check
            system("clear")
            puts "No more words to build from fragment. Fragment has been reset."
            @fragment = ""
            sleep(1)
            return true
        end

        false
    end

    def check_win
        @losses.values.include?(MAX_LOSS_COUNT)
    end

    def record(player)
        'GHOST'.slice(0, @losses[player])
    end

    def play_round
        player = self.current_player

        self.display_standings
        self.display_fragment
        self.take_turn(player)
        self.display_guess(player)
        self.completed_a_word?(player)

        self.next_player!
    end

    def run
        self.display_welcome

        until self.check_win
            self.play_round
        end

        self.display_winner
    end

    #UI
    def display_welcome
        puts "WELCOME TO THE GAME OF GHOST!"
        sleep(3)
    end

    def display_standings
        system("clear")

        puts "RECORD:"
        @players.each do |player|
            puts "#{player.name}: #{self.record(player)}"
        end

        sleep(1)
    end

    def completed_a_word?(player)
        if @dictionary.include?(@fragment)
            system("clear")
            puts "#{player.name} completed a word #{@fragment}!"
            @losses[player] += 1
            @fragment = ""
            sleep(2)
        end
    end

    def display_winner
        @players.each do |player|
            if @losses[player] != 5
                system("clear")
                puts player.name + " wins!"
            end
        end
    end

    def display_guess(player)
        system("clear")
        puts "#{player.name} entered #{player.guess}"
        sleep(1)
    end

    def display_fragment
        system("clear")
        puts "The fragment is #{@fragment.upcase}"
        puts
    end
end

if __FILE__ == $PROGRAM_NAME
    a = Player.new("Player A")
    b = Player.new("Player B")
    game = Game.new(a, b)
    game.run
end