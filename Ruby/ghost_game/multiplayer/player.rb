class Player
    attr_reader :name
    attr_accessor :guess

    def initialize(name)
        @name = name
        @guess = ""
    end

    def alert_invalid_guess
        puts "The move you entered is invalid (only input letters),"
        puts "or the letter can't build a fragment of word from the dictionary"
    end
end