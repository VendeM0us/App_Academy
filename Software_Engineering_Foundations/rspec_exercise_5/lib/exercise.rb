def zip(*arrs)
    zipped = Array.new(arrs[0].length) { Array.new([]) }
    
    arrs.each_with_index do |arr, i1|
        arr.each_with_index do |el, i2|
            zipped[i2][i1] = el
        end
    end

    zipped
end

def prizz_proc(arr, prc_1, prc_2)
    arr.select { |el| (prc_1.call(el) || prc_2.call(el)) && !(prc_1.call(el) && prc_2.call(el)) }
end

def get_max_length(arrs)
    max = arrs.inject do |max, cur|
        if max.length < cur.length
            max = cur
        else
            max
        end
    end

    max.length
end

def zany_zip(*arrs)
    zipped = Array.new(get_max_length(arrs)) { Array.new(arrs.length) }
    
    arrs.each_with_index do |arr, i1|
        arr.each_with_index do |el, i2|
            zipped[i2][i1] = el
        end
    end

    zipped
end

def maximum(arr, &prc)
    arr.inject do |max, el|
        if prc.call(el) >= prc.call(max)
            max = el
        else
            max
        end
    end
end

def my_group_by(arr, &prc)
    group = Hash.new { |h, k| h[k] = [] }
    arr.each { |el| group[prc.call(el)] << el }
    group
end

def max_tie_breaker(arr, prc, &blk)
    return nil if arr.empty?

    arr.inject do |max, el|
        if blk.call(el) > blk.call(max)
            max = el
        elsif blk.call(el) == blk.call(max)
            if prc.call(el) > prc.call(max)
                max = el
            else
                max
            end
        else
            max
        end
    end
end

def silly_syllables(sentence)
    new_sentence = sentence.split.map do |word|
        vowels = []
        word.each_char.each_with_index { |ch, i| vowels << i if "aeiou".include?(ch) }
        i1 = vowels[0]
        i2 = vowels[-1]

        if vowels.length >= 2
            word[i1..i2]
        else
            word
        end
    end

    new_sentence.join(" ")
end