class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position(legal_positions)
        illegal_input = true

        while illegal_input
            puts "Player #{@mark}, enter two numbers representing a position in the format `row col`"
            pos = gets.chomp.split
            
            nums = "0123456789"
            pos.each do |el|
                el.each_char { |ch| raise "Invalid input" if !nums.include?(ch) }
            end
            raise "Invalid input" if pos.length != 2

            pos.map!(&:to_i)

            if legal_positions.include?(pos)
                illegal_input = false
            else
                puts "position #{pos} is already not empty."
            end
        end

        pos
    end
end