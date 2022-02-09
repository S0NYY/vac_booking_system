# ...
class OrderCancellationsController < ApplicationController
  def find_order
    @orders = Order.find_by(order_code: params[:order_code])
    if @orders.patient.mobile_phone == params[:mobile_phone]
      render partial: 'step1'
    else
      render partial: 'missing'
    end
  end

  def send_verification
    find_current_order

    sms_code = Web::VerifySmsService.new(@booking_id).call

    SendVerifySmsWorker.perform_async(sms_code.id)
  end

  def verify_code
    find_current_order

    current_order_sms = VerifySmsMessage.where(booking_id: @booking_id).last

    if current_order_sms.code != params[:code_input]
      render partial: 'missing'

    else
      redirect_to root_path if @current_order.update(finished: false)
    end
  end

  private

  def find_current_order
    @current_order = Order.find(params[:id])
    @booking_id = Booking.find_by(order: @current_order).id
  end
end
