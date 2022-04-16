class Map
  attr_reader :map

  def initialize
    @map = []
  end

  def set(key, val)
    map.each.with_index do |pair, i|
      ref_key, ref_val = pair
        if ref_key == key
          map[i] = [key, val] 
          return [key, val]
        end
    end

    map << [key, val]
    return [key,val]
  end

  def get(key)
    map.each do |pair|
      ref_key, val = pair
      return val if ref_key == key
    end

    nil
  end

  def delete(key)
    map.each do |pair|
      ref_key, val = pair
      if ref_key == key
        map.delete(pair) 
        return puts "deleted:\n#{key} :  #{val}"
      end
    end

    nil
  end

  def show
    map.each do |pair|
      key, val = pair
      puts "#{key} : #{val}"
    end
  end
end