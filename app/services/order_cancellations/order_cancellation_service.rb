module Services
  # ...
  class OrderCancellationService
    attr_reader :result

    def initialize
      @result = OpenStruct.new(success?: false)
    end

    def update(id, params)
      find_record(id)

      result.tap do |r|
        r.send('success?=', r.order.update(params))
      end
    end

    private

    def find_order(id)
      result.order = Order.find(id) && Booking.find_by(order: result).id
      result
    end
  end
end
