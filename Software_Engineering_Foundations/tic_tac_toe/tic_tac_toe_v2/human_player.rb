class HumanPlayer
    attr_reader :mark

    def initialize(mark_value)
        @mark = mark_value
    end

    def get_position
        puts "Player #{@mark}, enter two numbers representing a position in the format `row col`"
        pos = gets.chomp.split
        
        nums = "0123456789"
        pos.each do |el|
            el.each_char { |ch| raise "Invalid input" if !nums.include?(ch) }
        end
        raise "Invalid input" if pos.length != 2

        pos.map(&:to_i)
    end
end