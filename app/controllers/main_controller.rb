class MainController < ApplicationController
  before_action :fetch_booking, only: %i[current_step next_step]

  def index
    @vaccine_items = VaccinesItem.active
  end

  def current_step

    result = Web::CurrentStepService.call(booking: @booking, params: params, collect_analytics: collect_analytics)

    if result.success? && result.record.present?
      @current_vaccine, @record = result.current_vaccine, result.record

      cookies.signed[:booking_uuid] = result.booking.guid

      render "main/steps/step#{result.render_step}"
    else
      cookies.delete(:booking_uuid)

      redirect_to root_url, notice: result.message
    end
  end

  def next_step
    
    return redirect_to root_url, notice: I18n.t('web.main.session_expired') unless @booking
    
    result = Web::NextStepService.call(booking: @booking, params: params)

    if result.success?
      return redirect_to root_url, notice: I18n.t('web.main.booking_success') if result.last_step?

      redirect_to current_step_path(result.booking.vaccine&.name)
    else
      @current_vaccine, @record = result.booking.vaccine, result.record

      render "main/steps/step#{result.current_step}" 
    end
  end

  def prev_step
  end

  def register
  end

  private

  def fetch_booking
    booking_uuid = cookies.signed[:booking_uuid]

    if booking_uuid.present?
      collect_analytics
      @booking = Booking.find_by(guid: booking_uuid)
    end
  end

  def collect_analytics
    browser = Browser.new(request.env["HTTP_USER_AGENT"])
    {
    user_ip:  request.remote_ip,
    browser:  browser.name,
    platform: browser.platform.name
    }
  end

end