module Admin
  # ...
  class SmsController < ApplicationController
    def index
      @sms = OrderSmsMessage.all
    end
  end
end
