require 'byebug'

class ComputerPlayer
    attr_reader :known_cards
    attr_writer :previous_guess, :cards

    def initialize
        @known_cards = Hash.new
        @matched_cards = Array.new
        @previous_guess = ''
        @cards = Array.new
    end

    def receive_revealed_card(pos, val)
        @known_cards[pos] = val
    end

    def receive_match(pos_1, pos_2)
        @matched_cards << [pos_1, pos_2]
    end

    def cards_flipped?(pos)
        idx_1, idx_2 = pos
        @cards[idx_1][idx_2] != ' '
    end

    def first_guess
        @matched_cards.each do |pair|
            guess = pair.sample
            return guess unless self.cards_flipped?(guess)
        end

        self.random_guess
    end

    def second_guess(first_guess)
        val_1 = @known_cards.fetch(first_guess)

        @known_cards.each do |pos, val_2|
            return pos if val_1 == val_2 && !self.cards_flipped?(pos)
        end

        self.random_guess
    end

    def random_guess
        valid_guess = false

        while !valid_guess
            idx_1 = rand(0..3)
            idx_2 = rand(0..3)
            guess = [idx_1, idx_2]

            valid_guess = true if !@known_cards.has_key?(guess)
        end

        guess
    end

    def get_input
        puts 'Please enter the position of the card you\'d like to flip (e.g \'2 3\')'
        print '> '

        if @previous_guess.empty?
            guess = self.first_guess
        else
            guess = self.second_guess(@previous_guess)
        end

        print guess.join(' ')
        sleep(1)
        guess
    end
end