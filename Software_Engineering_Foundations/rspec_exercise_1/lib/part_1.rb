def average(num1, num2)
    (num1 + num2) / 2.0
end

def average_array(arr)
    arr.sum / ((arr.length) * 1.0)
end

def repeat(str, num)
    str * num
end

def yell(str)
    str.upcase + "!"
end

def alternating_case(str)
    str_array = str.split

    i = 0
    while i < str_array.length
        str_array[i].upcase!

        i += 2
    end

    i = 1
    while i < str_array.length
        str_array[i].downcase!

        i += 2
    end

    str_array.join(" ")
end