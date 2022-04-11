def matrix_addition_reloaded(*sqrs)
    (0...sqrs.length - 1).each { |i| return nil if sqrs[i].length != sqrs[i + 1].length }

    new_mtr = Array.new(sqrs[0].length) { Array.new(sqrs[0][0].length, 0) }

    sqrs.each do |mtr|
        (0...mtr.length).each do |i1|
            (0...mtr[i1].length).each do |i2|
                new_mtr[i1][i2] += mtr[i1][i2]
            end
        end
    end

    new_mtr
end

# matrix_a = [[2,5], [4,7]]
# matrix_b = [[9,1], [3,0]]
# matrix_c = [[-1,0], [0,-1]]
# matrix_d = [[2, -5], [7, 10], [0, 1]]
# matrix_e = [[0 , 0], [12, 4], [6,  3]]

# p matrix_addition_reloaded(matrix_a, matrix_b)              # [[11, 6], [7, 7]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_c)    # [[10, 6], [7, 6]]
# p matrix_addition_reloaded(matrix_e)                        # [[0, 0], [12, 4], [6, 3]]
# p matrix_addition_reloaded(matrix_d, matrix_e)              # [[2, -5], [19, 14], [6, 4]]
# p matrix_addition_reloaded(matrix_a, matrix_b, matrix_e)    # nil
# p matrix_addition_reloaded(matrix_d, matrix_e, matrix_c)    # nil

def squarocol?(sqr)
    rows_and_columns = sqr.dup + sqr.transpose
    
    rows_and_columns.any? do |sqr|
        sqr.uniq.length == 1
    end
end

# p squarocol?([
#     [:a, :x , :d],
#     [:b, :x , :e],
#     [:c, :x , :f],
# ]) # true

# p squarocol?([
#     [:x, :y, :x],
#     [:x, :z, :x],
#     [:o, :o, :o],
# ]) # true

# p squarocol?([
#     [:o, :x , :o],
#     [:x, :o , :x],
#     [:o, :x , :o],
# ]) # false

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 7],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # true

# p squarocol?([
#     [1, 2, 2, 7],
#     [1, 6, 6, 0],
#     [0, 5, 2, 7],
#     [4, 2, 9, 7],
# ]) # false

def squaragonal?(sqr)
    #counts
    diag_1 = 1
    diag_2 = 1

    itr = 0
    (0...sqr.length - 1).each do |i|
        diag_1 += 1 if sqr[i][itr] == sqr[i + 1][itr + 1]
        diag_2 += 1 if sqr[i][-1 + -itr] == sqr[i + 1][(-1 + -itr) - 1]

        itr += 1
    end

    diag_1 == sqr.length || diag_2 == sqr.length
end

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :x, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [:x, :y, :o],
#     [:x, :o, :x],
#     [:o, :o, :x],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 7],
#     [1, 1, 6, 7],
#     [0, 5, 1, 7],
#     [4, 2, 9, 1],
# ]) # true

# p squaragonal?([
#     [1, 2, 2, 5],
#     [1, 6, 5, 0],
#     [0, 2, 2, 7],
#     [5, 2, 9, 7],
# ]) # false

def factorial(num)
    total = 1
    i = 1
    while i <= num
        total *= i
        i += 1
    end
    total
end

def pascals_triangle(num)
    arr = Array.new(num) { Array.new([]) }

    (0...num).each do |row|
        (0..row).each do |column|
            next_num = factorial(row) / (factorial(column) * factorial(row - column))
            arr[row] << next_num
        end
    end

    arr
end

# p pascals_triangle(5)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1]
# # ]

# p pascals_triangle(7)
# # [
# #     [1],
# #     [1, 1],
# #     [1, 2, 1],
# #     [1, 3, 3, 1],
# #     [1, 4, 6, 4, 1],
# #     [1, 5, 10, 10, 5, 1],
# #     [1, 6, 15, 20, 15, 6, 1]
# # ]