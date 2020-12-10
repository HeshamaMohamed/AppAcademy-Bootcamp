class Flight
    
    attr_reader :passengers
    
    def initialize(flightNo , capacity)
        @flight_number = flightNo
        @capacity = capacity
        @passengers = []
    end

    def full?
        @passengers.count >= @capacity       
    end

    def board_passenger(passenger)
        if !self.full?
            @passengers << passenger if passenger.has_flight?(@flight_number)
        end
    end

    def list_passengers
        @passengers.map(&:name)
    end

    def [](idx)
        @passengers[idx]
    end
    def <<(passenger)
        board_passenger(passenger)
    end
end