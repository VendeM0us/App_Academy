def partition(arr, num)
    new_array = Array.new(2) { [] }

    arr.each do |ele|
        if ele < num
            new_array[0] << ele
        else
            new_array[1] << ele
        end
    end

    new_array
end

def merge(hash_1, hash_2)
    {**hash_1, **hash_2}
end

def censor(sentence, arr)
    censored = sentence.split.map do |word|
        if arr.include?(word.downcase)
            censor_word(word)
        else
            word
        end
    end

    censored.join(" ")
end

def censor_word(word)
    vowels = "aeiou"
    word.each_char.with_index do |char, i|
        word[i] = "*" if vowels.include?(char.downcase)
    end
    word
end

def power_of_two?(num)
    power = 1

    while power <= num
        return true if power == num
        power *= 2
    end

    false
end