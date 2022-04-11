def is_prime?(num)
    return false if num < 2
    (2...num).none? { |fact| num % fact == 0 }
end

def nth_prime(num)
    primes = []

    i = 2
    until primes.length == num
        primes << i if is_prime?(i)

        i += 1
    end

    primes.max
end

def prime_range(min, max)
    range = []

    (min..max).each do |n|
        range << n if is_prime?(n)
    end

    range
end