def proper_factors(num)
    (1...num).select { |fact| num % fact == 0 }
end

def aliquot_sum(num)
    proper_factors(num).sum
end

def perfect_number?(num)
    num == aliquot_sum(num)
end

def ideal_numbers(n)
    perfect_nums = []

    i = 1
    until perfect_nums.length == n
        perfect_nums << i if perfect_number?(i)
        i += 1
    end

    perfect_nums
end