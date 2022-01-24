module Orders
  # ...
  class OrdersService
    attr_reader :result

    def initialize
      @result = OpenStruct.new(order: Order.new)
    end

    def list
      Order.all
    end
  end
end
