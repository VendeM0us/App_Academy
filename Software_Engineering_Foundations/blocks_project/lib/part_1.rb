def select_even_nums(arr)
    arr.select(&:even?)
end

def reject_puppies(dogs)
    dogs.reject { |dog| dog["age"] <= 2 }
end

def count_positive_subarrays(arr)
    arr.count { |nums| nums.sum > 0 }
end

def aba_translate(word)
    vowels = "aeiou"
    transformed = ""

    word.each_char do |char|
        if vowels.include?(char)
            transformed += char + "b" + char
        else
            transformed += char
        end
    end

    transformed
end

def aba_array(arr)
    arr.map { |word| aba_translate(word) }
end