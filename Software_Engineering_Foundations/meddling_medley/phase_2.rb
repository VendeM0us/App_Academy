def conjunct_select(arr, *prcs)
    arr.select { |el| prcs.all? { |prc| prc.call(el) } }
end

# is_positive = Proc.new { |n| n > 0 }
# is_odd = Proc.new { |n| n.odd? }
# less_than_ten = Proc.new { |n| n < 10 }

# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive) # [4, 8, 11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd) # [11, 7, 13]
# p conjunct_select([4, 8, -2, 11, 7, -3, 13], is_positive, is_odd, less_than_ten) # [7]

def pig_latin(word)
    vowels = "aeiou"
    compressed = ""

    if word.length < 3
        compressed = word
    elsif vowels.include?(word[0].downcase)
        compressed = word + "yay"
    else
        word.each_char.with_index do |ch, i|
            if vowels.include?(ch.downcase)
                compressed = word[i..-1] + word[0...i] + 'ay'
                break
            end
        end
    end

    return compressed.capitalize if word == word.capitalize
    compressed
end

def convert_pig_latin(sentence)
    sentence.split.map { |word| pig_latin(word) }.join(" ")
end

# p convert_pig_latin('We like to eat bananas') # "We ikelay to eatyay ananasbay"
# p convert_pig_latin('I cannot find the trash') # "I annotcay indfay ethay ashtray"
# p convert_pig_latin('What an interesting problem') # "Atwhay an interestingyay oblempray"
# p convert_pig_latin('Her family flew to France') # "Erhay amilyfay ewflay to Ancefray"
# p convert_pig_latin('Our family flew to France') # "Ouryay amilyfay ewflay to Ancefray"

def reverberate(sentence)
    vowels = 'aeiou'

    new_sentence = sentence.split.map do |word|
        new_word = ""

        if word.length < 3
            new_word = word
        elsif vowels.include?(word[-1].downcase)
            new_word = word * 2
        else
            i = word.length - 1
            while i >= 0
                if vowels.include?(word[i].downcase)
                    new_word = word + word[i..-1]
                    break
                end
                i -= 1
            end
        end

        new_word.capitalize! if word == word.capitalize
        new_word
    end

    new_sentence.join(" ")
end

# p reverberate('We like to go running fast') # "We likelike to go runninging fastast"
# p reverberate('He cannot find the trash') # "He cannotot findind thethe trashash"
# p reverberate('Pasta is my favorite dish') # "Pastapasta is my favoritefavorite dishish"
# p reverberate('Her family flew to France') # "Herer familyily flewew to Francefrance"

def disjunct_select(arr, *prcs)
    arr.select { |el| prcs.any? { |prc| prc.call(el) } }
end

# longer_four = Proc.new { |s| s.length > 4 }
# contains_o = Proc.new { |s| s.include?('o') }
# starts_a = Proc.new { |s| s[0] == 'a' }

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
# ) # ["apple", "teeming"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o
# ) # ["dog", "apple", "teeming", "boot"]

# p disjunct_select(['ace', 'dog', 'apple', 'teeming', 'boot', 'zip'],
#     longer_four,
#     contains_o,
#     starts_a
# ) # ["ace", "dog", "apple", "teeming", "boot"]

def remove_first_vowel(word)
    vowels = "aeiou"
    word.each_char.with_index do |ch, i|
        if vowels.include?(ch.downcase)
            return word[0...i] + word[i + 1..-1]
        end
    end
end

def remove_last_vowel(word)
    vowels = "aeiou"
    i = word.length - 1
    while i >= 0
        if vowels.include?(word[i].downcase)
            return word[0...i] + word[i + 1..-1]
        end
        i -= 1
    end
end

def alternating_vowel(sentence)
    new_sentence = []

    sentence.split.each_with_index do |word, i|
        if i.even? || i == 0
            new_sentence << remove_first_vowel(word)
        else
            new_sentence << remove_last_vowel(word)
        end
    end

    new_sentence.join(" ")
end

# p alternating_vowel('panthers are great animals') # "pnthers ar grat animls"
# p alternating_vowel('running panthers are epic') # "rnning panthrs re epc"
# p alternating_vowel('code properly please') # "cde proprly plase"
# p alternating_vowel('my forecast predicts rain today') # "my forecst prdicts ran tday"

def silly_talk(sentence)
    vowels = "aeiou"

    new_sentence = sentence.split.map do |word|
        new_word = ""

        if vowels.include?(word[-1])
            new_word = word + word[-1]
        else
            word.each_char.with_index do |ch, i|
                if vowels.include?(ch.downcase)
                    new_word += ch + 'b' + ch 
                else
                    new_word += ch
                end
            end
        end

        new_word.capitalize! if word == word.capitalize
        new_word
    end

    new_sentence.join(" ")
end

# p silly_talk('Kids like cats and dogs') # "Kibids likee cabats aband dobogs"
# p silly_talk('Stop that scooter') # "Stobop thabat scobooboteber"
# p silly_talk('They can code') # "Thebey caban codee"
# p silly_talk('He flew to Italy') # "Hee flebew too Ibitabaly"

def compress(str)
    count = 1
    compressed = ""

    (0...str.length).each do |i|
        if str[i] == str[i + 1]
            count += 1
        else
            if count > 1
                compressed += str[i] + count.to_s
            else
                compressed += str[i]
            end

            count = 1
        end
    end

    compressed
end

# p compress('aabbbbc')   # "a2b4c"
# p compress('boot')      # "bo2t"
# p compress('xxxyxxzzzz')# "x3yx2z4"