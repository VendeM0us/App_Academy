def element_count(arr)
    count = Hash.new(0)
    arr.each { |el| count[el] += 1 }
    count
end

def char_replace!(str, hash)
    str.each_char.with_index do |ch, i|
        if hash.has_key?(ch)
            str[i] = hash[ch]
        end
    end

    str
end

def product_inject(arr)
    arr.inject(:*)
end