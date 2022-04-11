require_relative "./dictionary.rb"

class Hangman
  DICTIONARY = WORDS_ARRAY

  def self.random_word
    DICTIONARY.sample
  end

  def initialize
    @secret_word = Hangman.random_word
    @guess_word = Array.new(@secret_word.length, "_")
    @attempted_chars = []
    @remaining_incorrect_guesses = 5
  end

  def guess_word
    @guess_word
  end

  def attempted_chars
    @attempted_chars
  end

  def remaining_incorrect_guesses
    @remaining_incorrect_guesses
  end

  def already_attempted?(char)
    @attempted_chars.include?(char)
  end

  def get_matching_indices(char)
    array = []

    @secret_word.each_char.with_index do |c, i|
      if c == char
        array << i
      end
    end

    array
  end

  def fill_indices(char, indices_array)
    indices_array.each do |i|
      @guess_word[i] = char
    end
  end

  def try_guess(char)
    matched_indices = get_matching_indices(char)
    fill_indices(char, matched_indices)

    @remaining_incorrect_guesses -= 1 if matched_indices.empty?

    if already_attempted?(char)
      puts "that has already been attempted"
      return false
    else
      @attempted_chars << char
      return true
    end
  end

  def ask_user_for_guess
    print "Enter a char: "
    guess = gets.chomp
    
    try_guess(guess)
  end

  def win?
    if @guess_word.join("") == @secret_word
      puts "WIN"
      return true
    else
      return false
    end
  end

  def lose?
    if @remaining_incorrect_guesses == 0
      puts "LOSE"
      return true
    else
      return false
    end
  end

  def game_over?
    if self.win? || self.lose?
      puts @secret_word
      return true
    end

    false
  end
end
