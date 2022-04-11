require_relative 'card'

class Board
    def initialize
        @board = Array.new(4) { Array.new(4, '') }
    end

    def populate
        alpha = (:A..:Z).to_a

        until self.full?
            card = alpha.sample

            p1_idx_1 = rand(0..3)
            p1_idx_2 = rand(0..3)
            p2_idx_1 = rand(0..3)
            p2_idx_2 = rand(0..3)

            pair_1_pos = [p1_idx_1, p1_idx_2]
            pair_2_pos = [p2_idx_1, p2_idx_2]

            if both_pair_empty?(pair_1_pos, pair_2_pos) && not_duplicate?(pair_1_pos, pair_2_pos)
                self[pair_1_pos] = Card.new(card)
                self[pair_2_pos] = Card.new(card)
                alpha.delete(card)
            end
        end
    end

    def both_pair_empty?(pair_1_pos, pair_2_pos)
        !self[pair_1_pos].instance_of?(Card) && !self[pair_2_pos].instance_of?(Card)
    end

    def not_duplicate?(pair_1_pos, pair_2_pos)
        pair_1_pos != pair_2_pos
    end

    def full?
        @board.all? do |row|
            row.none? { |card| !card.instance_of? Card }
        end
    end

    def [](pos)
        row, col = pos
        @board[row][col]
    end

    def []=(pos, val)
        row, col = pos
        @board[row][col] = val
    end

    def render
        puts [' ', '0', '1', '2', '3'].join(' ')
        @board.each.with_index do |row, i|
            puts "#{i} #{row.map { |card| card.face_value }.join(' ')}"
        end
    end

    def won?
        @board.all? do |row|
            row.none? { |card| card.face_value == ' ' }
        end
    end

    def reveal(guessed_pos)
        guess = self[guessed_pos]
        guess.reveal unless guess.face_up?
        guess.value
    end

    def get_face_values
        @board.map do |row|
            row.map { |card| card.face_value }
        end
    end
end