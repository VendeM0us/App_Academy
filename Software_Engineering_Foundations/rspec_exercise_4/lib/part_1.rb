def my_reject(arr, &prc)
    rejected = []

    arr.each do |el|
        rejected << el if !prc.call(el)
    end

    rejected
end

def my_one?(arr, &prc)
    count = 0

    arr.each do |el|
        count += 1 if prc.call(el)
    end

    count == 1
end

def hash_select(hash, &prc)
    selected = {}

    hash.each do |k, v|
        selected[k] = v if prc.call(k, v)
    end

    selected
end

def xor_select(arr, prc_1, prc_2)
    selected = []

    arr.each do |el|
        selected << el if (prc_1.call(el) || prc_2.call(el)) && !(prc_1.call(el) && prc_2.call(el))
    end

    selected
end

def proc_count(val, prcs)
    count = 0
    prcs.each { |prc| count += 1 if prc.call(val) }
    count
end