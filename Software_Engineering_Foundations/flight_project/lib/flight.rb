class Flight
    attr_reader :passengers

    def initialize(flight_number, capacity)
        @flight_number = flight_number
        @capacity = capacity
        @passengers = []
    end

    def full?
        @passengers.length == @capacity
    end

    def board_passenger(passenger)
        if !self.full?
            @passengers << passenger if passenger.has_flight?(@flight_number)
        end
    end

    def list_passengers
        list = []
        @passengers.each { |passenger| list << passenger.name }
        list
    end

    def [](idx)
        @passengers[idx]
    end

    def <<(passenger)
        self.board_passenger(passenger)
    end
end