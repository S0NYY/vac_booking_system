module Bookings
  # ...
  class BookingsService
    attr_reader :result

    def initialize
      @result = OpenStruct.new(booking: Booking.new)
    end

    def list
      Booking.all
    end

    private

    def find_record(id)
      result.booking = Booking.find(id)
      result
    end
  end
end
