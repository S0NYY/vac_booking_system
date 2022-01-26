# ...
class MainController < ApplicationController
  before_action :fetch_booking, only: %i[current_step next_step]
  before_action :clear_booking

  def index
    @vaccine_items = VaccinesItem.active
  end

  def current_step
    result = Web::CurrentStepService.call(booking: @booking, params: params, collect_analytics: collect_analytics)

    if result.success? && result.record.present?
      assign_step_variables({ vaccine: result.current_vaccine, record: result.record })

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
      if result.last_step?
        cookies.delete(:booking_uuid)

        return redirect_to root_url, notice: I18n.t('web.main.booking_success')
      end

      redirect_to current_step_path(result.booking.vaccine&.name)
    else
      assign_step_variables({ vaccine: result.booking.vaccine, record: result.record })

      render "main/steps/step#{result.current_step}"
    end
  end

  def prev_step; end

  def register; end

  private

  def assign_step_variables(attrs)
    @current_vaccine = attrs[:vaccine]
    @record = attrs[:record]
  end

  def fetch_booking
    booking_uuid = cookies.signed[:booking_uuid]

    if booking_uuid.present?
      @booking = Booking.find_by(guid: booking_uuid)
    end
  end

  def collect_analytics
    browser = Browser.new(request.env['HTTP_USER_AGENT'])
    {
    user_ip: request.remote_ip,
    browser: browser.name,
    platform: browser.platform.name
    }
  end

  def clear_booking
    if @booking&.finished?
      cookies.delete(:booking_uuid)

      redirect_to root_url
    end
  end
end
