# Monkey-Patch Ruby's existing Array class to add your own custom methods
require "byebug"

class Array
    def span
        return nil if self.empty?

        self.max - self.min
    end

    def average
        return nil if self.empty?

        self.sum / (self.length * 1.0)
    end

    def median
        return nil if self.empty?

        if self.length.odd?
            idx = (self.length / 2) 

            self.sort[idx]
        else
            idx_1 = (self.length / 2) - 1
            idx_2 = (self.length / 2)

            self.sort!
            [self[idx_1], self[idx_2]].average
        end
    end

    def counts
        counts = Hash.new(0)
        self.each { |ele| counts[ele] += 1 }
        counts
    end

    def my_count(el)
        count = 0
        self.each { |arr_el| count += 1 if arr_el == el }
        count
    end

    def my_index(el)
        i = 0

        while i < self.length
            return i if self[i] == el

            i += 1
        end

        nil
    end

    def my_uniq
        uniq = {}
        self.each { |el| uniq[el] = true }
        uniq.keys
    end

    def my_transpose
        transposed = []

        (0...self.length).each do |row|
            new_row = []

            (0...self.length).each do |col|
                new_row << self[col][row]
            end

            transposed << new_row
        end

        transposed
    end
end