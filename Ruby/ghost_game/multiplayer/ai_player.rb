require 'set'

class AI_Player
    attr_reader :name, :guess
    attr_writer :fragment, :n

    ALPHABET = ('a'..'z').to_a

    def initialize(name)
        @name = name
        @guess = ""
        @dictionary = Set.new File.readlines('dictionary.txt', chomp: true)
        @fragment = ""
        @n = 0
    end

    def winning_move?
        alpha_dup = ALPHABET.dup

        until alpha_dup.empty?
            letter = alpha_dup.sample
            possible_fragment = @fragment + letter

            if @fragment.length <= @n && @dictionary.any? { |word| word.include?(possible_fragment) }
                @guess = letter
                return true
            end

            alpha_dup.delete(letter)
        end

        false
    end

    def losing_move?
        alpha_dup = ALPHABET.dup

        until alpha_dup.empty?
            letter = alpha_dup.sample
            possible_fragment = @fragment + letter

            if @dictionary.include?(possible_fragment)
                @guess = letter
                return true
            end

            alpha_dup.delete(letter)
        end

        false
    end

    def last_resort_move?
        alpha_dup = ALPHABET.dup

        until alpha_dup.empty?
            letter = alpha_dup.sample
            possible_fragment = @fragment + letter

            if @dictionary.any? { |word| word.include?(possible_fragment) }
                @guess = letter
                return true
            end

            alpha_dup.delete(letter)
        end

        false
    end

    def make_guess
        return if self.winning_move?
        return if self.losing_move?
        return if self.last_resort_move?
    end
end