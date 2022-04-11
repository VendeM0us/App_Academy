def reverser(str, &prc)
    prc.call(str.reverse)
end


def word_changer(sentence, &prc)
    words = sentence.split

    words.map! do |word|
        prc.call(word)
    end

    words.join(" ")
end


def greater_proc_value(num, prc_1, prc_2)
    result_1 = prc_1.call(num)
    result_2 = prc_2.call(num)

    if result_1 > result_2
        result_1
    else
        result_2
    end
end


def and_selector(array, prc_1, prc_2)
    new_array = []

    array.each do |el|
        if prc_1.call(el) && prc_2.call(el)
            new_array << el
        end
    end

    new_array
end


def alternating_mapper(array, prc_1, prc_2)
    mapped = []

    array.each_with_index do |el, i|
        if i.even?
            mapped << prc_1.call(el)
        else
            mapped << prc_2.call(el)
        end
    end

    mapped
end