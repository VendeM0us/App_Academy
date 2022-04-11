def prime?(num)
    return false if num < 2
    (2...num).none? { |fact| num % fact == 0 }
end

def mersenne_prime(num)
    arr = []

    i = 2
    until arr.length == num
        next_num = 2**i - 1
        arr << next_num if prime?(next_num)
        i += 1
    end

    arr[-1]
end

# p mersenne_prime(1) # 3
# p mersenne_prime(2) # 7
# p mersenne_prime(3) # 31
# p mersenne_prime(4) # 127
# p mersenne_prime(6) # 131071

def to_num(word)
    value = 0
    alpha = ('a'..'z').to_a

    word.each_char do |ch|
        value += alpha.index(ch) + 1
    end

    value
end

def triangular_word?(word)
    (1..to_num(word)).each do |i|
        return true if (i * (i + 1)) / 2 == to_num(word)
    end

    false
end

# p triangular_word?('abc')       # true
# p triangular_word?('ba')        # true
# p triangular_word?('lovely')    # true
# p triangular_word?('question')  # true
# p triangular_word?('aa')        # false
# p triangular_word?('cd')        # false
# p triangular_word?('cat')       # false
# p triangular_word?('sink')      # false

def consecutive_collapse(arr)
    collapsible = true

    while collapsible
        collapsible = false

        (0...arr.length - 1).each do |i|
            if arr[i] - arr[i + 1] == 1 || arr[i] - arr[i + 1] == -1
                collapsible = true
                arr.delete_at(i)
                arr.delete_at(i)
                break
            end
        end
    end

    arr
end

# p consecutive_collapse([3, 4, 1])                     # [1]
# p consecutive_collapse([1, 4, 3, 7])                  # [1, 7]
# p consecutive_collapse([9, 8, 2])                     # [2]
# p consecutive_collapse([9, 8, 4, 5, 6])               # [6]
# p consecutive_collapse([1, 9, 8, 6, 4, 5, 7, 9, 2])   # [1, 9, 2]
# p consecutive_collapse([3, 5, 6, 2, 1])               # [1]
# p consecutive_collapse([5, 7, 9, 9])                  # [5, 7, 9, 9]
# p consecutive_collapse([13, 11, 12, 12])              # []

def nearest_prime_greater(el, n)
    i = el + 1
    nearest = el

    until n == 0
        if prime?(i)
            nearest = i
            n -= 1
        end

        i += 1
    end

    nearest
end

def nearest_prime_lesser(el, n)
    i = el - 1
    nearest = el

    until n == 0
        return nil if i < 2
        if prime?(i)
            nearest = i
            n += 1
        end
        
        i -= 1
    end

    nearest
end

def pretentious_primes(arr, n)
    arr.map do |el|
        if n >= 0
            nearest_prime_greater(el, n)
        else
            nearest_prime_lesser(el, n)
        end
    end
end

# p pretentious_primes([4, 15, 7], 1)           # [5, 17, 11]
# p pretentious_primes([4, 15, 7], 2)           # [7, 19, 13]
# p pretentious_primes([12, 11, 14, 15, 7], 1)  # [13, 13, 17, 17, 11]
# p pretentious_primes([12, 11, 14, 15, 7], 3)  # [19, 19, 23, 23, 17]
# p pretentious_primes([4, 15, 7], -1)          # [3, 13, 5]
# p pretentious_primes([4, 15, 7], -2)          # [2, 11, 3]
# p pretentious_primes([2, 11, 21], -1)         # [nil, 7, 19]
# p pretentious_primes([32, 5, 11], -3)         # [23, nil, 3]
# p pretentious_primes([32, 5, 11], -4)         # [19, nil, 2]
# p pretentious_primes([32, 5, 11], -5)         # [17, nil, nil]