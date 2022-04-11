require 'set'
require 'byebug'

class WordChainer
    def initialize(dictionary_file_name)
        @dictionary = Set.new(File.readlines(dictionary_file_name, chomp: true))
    end

    def adjacent_words(word)
        adjacents = []

        word.each_char.with_index do |old_char, i|
            ('a'..'z').to_a.each do |new_char|
                next if new_char == old_char

                test_word = word.dup 
                test_word[i] = new_char

                adjacents << test_word if @dictionary.include?(test_word)
            end
        end

        adjacents
    end

    def run(source, target)
        @current_words = [source]
        @all_seen_words = { source => nil }

        until @current_words.empty? || @all_seen_words.include?(target)
            self.explore_current_words 
        end

        self.build_path(target)
    end

    def explore_current_words
        new_current_words = []

        @current_words.each do |current_word|
            self.adjacent_words(current_word).each do |adjacent_word|
                unless @all_seen_words.include?(adjacent_word)
                    new_current_words << adjacent_word
                    @all_seen_words[adjacent_word] = current_word
                end
            end
        end
        @current_words = new_current_words
    end

    def build_path(target)
        paths = [target]
        word = target
        modifier = @all_seen_words[target]

        until modifier.nil?
            word, modifier = modifier, @all_seen_words[modifier]
            paths << word
        end

        paths.reverse
    end
end