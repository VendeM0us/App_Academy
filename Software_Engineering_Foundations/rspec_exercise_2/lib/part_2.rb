def palindrome?(string)
    word_backward = ""

    string.split("").reverse_each do |char|
        word_backward += char
    end

    string == word_backward
end

def substrings(string)
    array = []

    string.split("").each_index do |idx1|
        (idx1...string.length).each do |idx2|
            array << string[idx1..idx2]
        end
    end

    array
end

def palindrome_substrings(string)
    array = substrings(string)
    array.select { |substring| palindrome?(substring) && substring.length > 1 }
end