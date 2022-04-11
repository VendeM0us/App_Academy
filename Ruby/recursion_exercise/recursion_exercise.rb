require 'byebug'

def range(s, e) # s for start and e for end
    return [] if e < s
    return [s] if e - s <= 1
    range(s, e - 1) << e - 1
end

def recursive_array_sum(array)
    return array.first if array.length <= 1
    array.pop + recursive_array_sum(array)
end

def iterative_array_sum(array)
    array.inject { |sum, ele| sum + ele }
end

def exponent_ver1(b, n)
    return 1 if n == 0
    return b if n == 1
    b * exponent_ver1(b, n - 1)
end

def exponent_ver2(b, n)
    return 1 if n == 0
    return b if n == 1

    if n.even?
        exponent_ver2(b, n / 2) ** 2
    else
        b * (exponent_ver2(b, (n - 1) / 2) ** 2)
    end
end

class Array
    def deep_dup
        dup = []
        self.each do |ele|
            dup << (ele.is_a?(Array) ? ele.deep_dup : ele)
        end
        dup
    end
end

def fibonacci(n)
    return [] if n < 1
    return [0] if n == 1
    return [0, 1] if n == 2

    sequence = fibonacci(n - 1)
    sequence << sequence[-1] + sequence[-2]
end

def bsearch(array, target)
    return nil if array.empty?
    
    mid = array.length / 2
    
    case target <=> array[mid]
    when 1
        sub_answer = bsearch(array.drop(mid + 1), target)
        sub_answer.nil? ? nil : (mid + 1) + sub_answer
    when -1
        bsearch(array.take(mid), target)
    when 0
        mid
    end
end

def merge(arr_1, arr_2)
    return arr_1 if arr_2.empty?
    return arr_2 if arr_1.empty?

    if arr_1.first <= arr_2.first
        smallest_num = arr_1.shift
    else
        smallest_num = arr_2.shift
    end

    [smallest_num].concat(merge(arr_1, arr_2))
end

def merge_sort(array)
    return array if array.length <= 1

    first_half = merge_sort(array.take(array.length / 2))
    second_half = merge_sort(array.drop(array.length / 2))

    merge(first_half, second_half)
end 

def subsets(array)
    return [[]] if array.length == 0

    first_subsets = subsets(array.slice(0, array.length - 1)) 
    second_subsets = first_subsets.map { |subset| subset.dup << array.last }

    first_subsets + second_subsets
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3]) # => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]
# p subsets([1, 2, 3, 4])


def permutations(array)
    return [array] if array.length <= 1

    permutated = []

    array.each.with_index do |ele, i|
        array_dup = array.dup
        array_dup.delete_at(i)

        arrays = permutations(array_dup).map do |sub_permutation|
            [ele].concat(sub_permutation)
        end

        permutated.concat(arrays)
    end

    permutated
end

# p permutations([1, 2, 3])

def greedy_make_change(amount, coins)
    return [] if amount == 0

    coins.sort.reverse.each do |change|
        remaining_amount = amount - change
        return [change].concat(greedy_make_change(remaining_amount, coins)) unless remaining_amount < 0
    end
end

def make_better_change(amount, coins)
    return [] if amount == 0

    best_change = nil

    coins.each do |coin|
        next if coin > amount

        other_changes = make_better_change(amount - coin, coins)
        change = [coin].concat(other_changes)

        if best_change.nil? || best_change.count > change.count
            best_change = change
        end
    end

    best_change
end