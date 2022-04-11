require 'set'
require_relative 'player'
require_relative 'ai_player'

class Game
    ALPHABET = ('a'..'z').to_a
    MAX_LOSS_COUNT = 5

    def initialize(*players)
        @players = players
        @players_original = @players.dup
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

    def set_ai_player(player)
        if player.instance_of? AI_Player
            player.fragment = @fragment
            player.n = @players.count
            player.make_guess
        end
    end

    def take_turn(player) 
        self.check_if_no_more_words_to_build
        self.set_ai_player(player)
        
        valid_turn = false

        while !valid_turn
            puts "#{player.name}, enter a letter: "
            player.guess = gets.chomp.downcase unless player.instance_of? AI_Player
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

    def completed_a_word?(player)
        if @dictionary.include?(@fragment)
            system("clear")
            puts "#{player.name} completed a word #{@fragment}!"
            @losses[player] += 1
            @fragment = ""
            sleep(2)

            return true
        end

        false
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

    def remove_loser
        @players.each do |player|
            if @losses[player] == MAX_LOSS_COUNT
                system("clear")
                puts "#{player.name} is now a ghost! #{player.name} will now be removed from the game"
                @players.delete(player)
                sleep(2)
            end
        end
    end

    def check_win
        @players.count == 1
    end

    def record(player)
        'GHOST'.slice(0, @losses[player])
    end

    def display_welcome
        puts "WELCOME TO THE GAME OF GHOST!"
        sleep(2.5)
    end

    def display_standings
        system("clear")

        puts "RECORD:"
        @players_original.each do |player|
            puts "#{player.name}: #{self.record(player)}"
        end

        sleep(2)
    end

    def display_winner
        system("clear")
        puts "#{@players[0].name} wins!"
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

    def play_round
        player = self.current_player

        self.display_fragment
        self.take_turn(player)
        self.display_guess(player)

        if self.completed_a_word?(player)
            self.remove_loser
            self.display_standings
        end

        self.next_player!
    end

    def run
        self.display_welcome
        self.display_standings

        until self.check_win
            self.play_round
        end

        self.display_winner
    end
end

if __FILE__ == $PROGRAM_NAME
    ai = AI_Player.new("AI Player")
    mayo = Player.new("Mayo")
    game = Game.new(mayo, ai)
    game.run
end