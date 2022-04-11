require_relative "room"

class Hotel
  def initialize(hotel_name, rooms_hash)
    @name = hotel_name
    @rooms = {}

    rooms_hash.each do |room_name, room_capacity|
        @rooms[room_name] = Room.new(room_capacity)
    end
  end

  def name
    capitalized_name = []

    @name.split.each do |part|
        capitalized_name << part.capitalize
    end

    capitalized_name.join(" ")
  end

  def rooms
    @rooms
  end

  def room_exists?(room_name)
    @rooms.has_key?(room_name)
  end

  def check_in(person, room_name)
    if room_exists?(room_name)
      if @rooms[room_name].add_occupant(person)
        puts "check in successful"
      else
        puts "sorry, room is full"
      end
    else
      puts "sorry, room does not exist"
    end
  end

  def has_vacancy?
    @rooms.values.any? { |room| !room.full? }
  end

  def list_rooms
    @rooms.each do |room_name, capacity|
      puts room_name + " #{capacity.available_space}"
    end
  end
end
