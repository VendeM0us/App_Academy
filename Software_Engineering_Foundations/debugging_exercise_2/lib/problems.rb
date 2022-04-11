# Run `bundle exec rspec` and satisy the specs.
# You should implement your methods in this file.
# Feel free to use the debugger when you get stuck.

require "byebug"

def largest_prime_factor(number)
    array = []

    (1..number).each do |i|
        array << i if prime?(i) && number % i == 0
    end

    array.max
end

def prime?(num)
    return false if num < 2

    (2...num).each do |factor|
        return false if num % factor == 0
    end

    true
end

def unique_chars?(string)
    char_count = Hash.new(0)

    string.each_char do |char|
        char_count[char] += 1
    end

    char_count.each_value { |value| return false if value > 1 }
    true
end

def dupe_indices(array)
    #Old code:
    # hash = Hash.new(0)

    # array.each { |ele| hash[ele]+=1 }
    # hash.keep_if { |key, value| value > 1 }
    # hash.transform_values! { |value| [] }
    
    # array.each_with_index do |ele, i|
    #     hash[ele] << i if hash.has_key?(ele)
    # end

    # hash
    hash = Hash.new { |h, k| h[k] = [] }
    
    array.each_with_index do |ele, i|
        hash[ele] << i
    end

    hash.select { |k, v| v.length > 1 }
end

def ele_count(arr)
    count = Hash.new(0)
    arr.each { |ele| count[ele] += 1 }
    count
end

def ana_array(arr1, arr2)
    ele_count(arr1) == ele_count(arr2)
end