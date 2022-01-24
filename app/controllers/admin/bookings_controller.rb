module Admin
  # ...
  class BookingsController < ApplicationController
    before_action :init_service

    def index
      @pagy, @bookings = pagy(@booking_service.list)
    end

    private

    def init_service
      @booking_service = Bookings::BookingsService.new
    end
  end
end
