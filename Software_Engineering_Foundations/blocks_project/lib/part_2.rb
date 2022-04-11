def all_words_capitalized?(words)
    words.all? { |word| word.capitalize == word }
end

def no_valid_url?(urls)
    valid_domain = [".com", ".net", ".io", ".org"]

    urls.none? do |url|
        valid_domain.any? { |domain| url.end_with?(domain) }
    end
end

def passing_grade?(student)
    average = student[:grades].sum / (student[:grades].length * 1.0)
    average >= 75
end

def any_passing_students?(students)
    students.any? { |student| passing_grade?(student) }
end