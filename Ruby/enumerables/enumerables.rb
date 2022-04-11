lass Array
    def my_each(&prc)
        i = 0
        while i < self.length
            prc.call(self[i])
            i += 1
        end

        self
    end

    def my_select(&prc)
        selected = []

        self.my_each do |ele|
            selected << ele if prc.call(ele)
        end

        selected
    end

    def my_reject(&prc)
        rejected = []

        self.my_each do |ele|
            rejected << ele if !prc.call(ele)
        end

        rejected
    end

    def my_any?(&prc)
        self.my_each do |ele|
            return true if prc.call(ele)
        end
        false
    end

    def my_all?(&prc)
        self.my_each do |ele|
            return false if !prc.call(ele)
        end
        true
    end

    def my_flatten
        flattened = []

        self.my_each do |ele|
            if ele.instance_of? Array
                flattened += ele.my_flatten
            else
                flattened << ele
            end
        end

        flattened
    end

    def my_zip(*arrays)
        zipped = Array.new(self.length) { Array.new(arrays.length + 1, nil) }
        all_arrays = [self] + arrays
        
        zipped.each.with_index do |ele, i1|
            ele.each_index do |i2|
                zipped[i1][i2] = all_arrays[i2][i1]
            end
        end

        zipped
    end

    def my_rotate(num = 1)
        rotated = []

        self.each.with_index do |ele, i|
            rotated_index = (i - num) % self.length
            rotated[rotated_index] = ele
        end

        rotated
    end

    def my_join(separator = "")
        joined = ""

        self.each.with_index do |ele, i|
            max_index = self.index(self[-1])
            if i != max_index
                joined += ele + separator
            else
                joined += ele
            end
        end

        joined
    end

    def my_reverse
        reversed = []

        i = self.length - 1
        while i >= 0
            reversed << self[i]

            i -= 1
        end

        reversed
    end
end