
class Passenger

    attr_reader :name
    

    def initialize(name)
        @name = name
        @flight_numbers =[]
    end

    def has_flight?(flightNumber)
        return true if @flight_numbers.include?(flightNumber.upcase)
        false
    end

    def add_flight(flightNumber)
        @flight_numbers << flightNumber.upcase if !self.has_flight?(flightNumber)
    end
end