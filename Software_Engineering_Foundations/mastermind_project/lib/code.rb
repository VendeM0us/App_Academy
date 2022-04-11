class Code
  attr_reader :pegs

  POSSIBLE_PEGS = {
    "R" => :red,
    "G" => :green,
    "B" => :blue,
    "Y" => :yellow
  }

  def self.valid_pegs?(chars)
    chars.all? { |char| POSSIBLE_PEGS.has_key?(char.upcase) }
  end

  def self.random(num)
    random_pegs = Array.new(num)

    random_pegs.each_index do |i|
      random_pegs[i] = POSSIBLE_PEGS.keys.sample
    end

    Code.new(random_pegs)
  end

  def self.from_string(pegs)
    Code.new(pegs.split(""))
  end

  def initialize(chars)
    if Code.valid_pegs?(chars)
      @pegs = chars.map(&:upcase)
    else
      raise "Invalid pegs!"
    end
  end

  def [](index)
    @pegs[index]
  end

  def length
    @pegs.length
  end

  def num_exact_matches(guess)
    count = 0

    (0...guess.length).each do |i|
      count += 1 if guess[i] == self[i]
    end

    count
  end

  def num_near_matches(guess)
    pegs_dup = self.pegs.dup
    guess_dup = guess.pegs.dup

    guess_dup.each_index do |i|
      if guess_dup[i] == pegs_dup[i]
        guess_dup[i] = nil
        pegs_dup[i] = nil
      end
    end
    guess_dup.delete(nil)
    pegs_dup.delete(nil)

    count = 0

    guess_dup.each do |peg|
      if pegs_dup.include?(peg)
        count += 1
        pegs_dup.delete_at(pegs_dup.index(peg))
      end
    end

    count 
  end

  def ==(code_instance)
    self.pegs == code_instance.pegs
  end
end