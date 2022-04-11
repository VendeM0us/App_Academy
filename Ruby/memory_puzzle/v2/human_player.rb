class HumanPlayer
    attr_reader :known_cards
    attr_writer :previous_guess, :cards

    def initialize
        @known_cards = Hash.new
        @matched_cards = Array.new
        @previous_guess = ''
        @cards = Array.new
    end

    def get_input
        puts 'Please enter the position of the card you\'d like to flip (e.g \'2 3\')'
        print '> '
        gets.chomp.split.map(&:to_i)
    end

    def receive_revealed_card(pos, val)
        @known_cards[pos] = val
    end

    def receive_match(pos_1, pos_2)
        @matched_cards << [pos_1, pos_2]
    end
end