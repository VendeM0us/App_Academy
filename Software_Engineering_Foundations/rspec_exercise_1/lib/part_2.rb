def hipsterfy(word)
    vowel = "aeiou"

    i = word.length - 1
    while i >= 0
        if vowel.include?(word[i])
            word[i] = ""
            break
        end
    
        i -= 1
    end

    word
end

def vowel_counts(str)
    vowel = "aeiou"
    vowel_counts = Hash.new(0)
    str.each_char { |char| vowel_counts[char.downcase] += 1 if vowel.include?(char.downcase) }
    vowel_counts
end

def caesar_cipher(message, n)
    alphabet = "abcdefghijklmnopqrstuvwxyz"

    message.each_char.with_index do |char, i|
        if alphabet.include?(char)
            old_index = alphabet.index(char)
            new_index = (old_index + n) % 26
            message[i] = alphabet[new_index]
        end
    end

    message
end