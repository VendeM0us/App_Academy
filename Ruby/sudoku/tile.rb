require 'colorize'

class Tile
    attr_accessor :value

    def initialize(given_value)
        @given_value = given_value
        @value = given_value
    end

    def given?
        @given_value != 0
    end

    def to_s
        if @value != 0
            if self.given?
                return @value.to_s.colorize(:color => :light_yellow).underline
            else
                return @value.to_s.colorize(:color => :light_white).underline
            end
        else
            return ' '.colorize(:color => :light_white).underline
        end
    end
end