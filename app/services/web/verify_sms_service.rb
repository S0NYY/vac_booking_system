module Web
  # ...
  class VerifySmsService
    attr_accessor :booking

    def initialize(booking_id)
      @booking_id = booking_id
    end

    def call
      sms_code = 4.times.map { rand(9) }.join
      VerifySmsMessage.create!(booking_id: @booking_id, code: sms_code, approved_at: DateTime.now)
    end
  end
end
