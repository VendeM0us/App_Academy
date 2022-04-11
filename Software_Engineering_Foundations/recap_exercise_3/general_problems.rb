def no_dupes?(arr)
    arr.select do |el|
        count = 0

        arr.each do |is_dup|
            count += 1 if el == is_dup
        end

        count == 1
    end
end

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    (0...arr.length - 1).each do |i|
        return false if arr[i] == arr[i + 1]
    end

    true
end

# puts no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# puts no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# puts no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# puts no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# puts no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    indices = Hash.new { |h, k| h[k] = [] }

    str.each_char.with_index do |char, i|
        indices[char] << i
    end

    indices
end

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    consecutives = ""
    longest_consecutives = ""

    (0...str.length).each do |i|
        if str[i] == str[i + 1] 
            consecutives += str[i]
        else
            consecutives += str[i]

            if consecutives.length >= longest_consecutives.length
                longest_consecutives = consecutives
            end

            consecutives = ""
        end
    end

    longest_consecutives
end

# puts longest_streak('a')           # => 'a'
# puts longest_streak('accccbbb')    # => 'cccc'
# puts longest_streak('aaaxyyyyyzz') # => 'yyyyy
# puts longest_streak('aaabbb')      # => 'bbb'
# puts longest_streak('abc')         # => 'c'

def prime?(num)
    return false if num < 2

    (2...num).none? { |factor| num % factor == 0 }
end

def bi_prime?(num)
    primes = []

    (2..num).each { |n| primes << n if prime?(n) && num % n == 0 }

    primes.each do |n1|
        primes.each do |n2|
            return true if n1 * n2 == num
        end
    end

    false
end

# puts bi_prime?(14)   # => true
# puts bi_prime?(22)   # => true
# puts bi_prime?(25)   # => true
# puts bi_prime?(94)   # => true
# puts bi_prime?(24)   # => false
# puts bi_prime?(64)   # => false

def vigenere_cipher(message, keys)
    begin
        ciphered = ""
        alpha = ("a".."z").to_a

        message.each_char.with_index do |char, i|
            old_idx = alpha.index(char)
            new_idx = (old_idx + keys[i % keys.length]) % alpha.length
            new_char = alpha[new_idx]

            ciphered += new_char
        end

        ciphered
    rescue
        puts "This program only accepts lowercase characters!"
    end
end

# puts vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# puts vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# puts vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# puts vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# puts vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    str_vowels = str.split("").select { |char| "aeiou".include?(char) }

    idx = - 1
    (0...str.length).each do |i|
        if str_vowels.include?(str[i])
            str[i] = str_vowels[idx % str_vowels.length]
            idx += 1
        end
    end

    str
end

# puts vowel_rotate('computer')      # => "cempotur"
# puts vowel_rotate('oranges')       # => "erongas"
# puts vowel_rotate('headphones')    # => "heedphanos"
# puts vowel_rotate('bootcamp')      # => "baotcomp"
# puts vowel_rotate('awesome')       # => "ewasemo"