require_relative "code"

class Mastermind
    def initialize(length)
        @secret_code = Code.random(length)
    end

    def print_matches(matches)
        puts "Number of exact matches: #{@secret_code.num_exact_matches(matches)}"
        puts "Number of near matches: #{@secret_code.num_near_matches(matches)}"
    end

    def ask_user_for_guess
        print "Enter a code: "
        guess = Code.from_string(gets.chomp)
        self.print_matches(guess)
        guess == @secret_code
    end
end
