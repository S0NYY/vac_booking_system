module Admin
  class BookingsController < ApplicationController

    def index
      @pagy, @bookings = pagy(Booking.all)
    end
  
  end
end