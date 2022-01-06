class MainController < ApplicationController
  before_action :fetch_booking, only: %i[current_step next_step]

  include DowncaseHelper
  
  def index
    @vaccine_items = VaccinesItem.active
  end

  def current_step
    @current_vaccine = VaccinesItem.active.where("lower(name) = ?", downcase(params[:vaccine])).first

    return redirect_to root_url unless @current_vaccine

    case 

    when @booking && @booking.vaccine.name != @current_vaccine.name
      web_step = Web::Step0Service.new(@current_vaccine)
      web_step.call(nil)
      
      @booking ||= web_step.booking
      @current_vaccine, @record = web_step.current_vaccine, web_step.record

      cookies.signed[:booking_uuid] = { value: @booking.guid, expires: 30.minutes.from_now }
      render :step0  

    when @booking&.pending?
      web_step = Web::Step0Service.new(@current_vaccine)
      web_step.call(@booking)

      @current_vaccine, @record = web_step.current_vaccine, web_step.record
      
      render :step0

    when @booking.nil?
      web_step = Web::Step0Service.new(@current_vaccine)
      web_step.call(@booking)

      @booking ||= web_step.booking
      @current_vaccine, @record = web_step.current_vaccine, web_step.record

      cookies.signed[:booking_uuid] = { value: @booking.guid, expires: 30.minutes.from_now }

        render :step0 

    when @booking.patiend_upserted?
      render :step1

    when @booking.reserved?
      render :step2

    else
      cookies.delete(:booking_uuid)
      redirect_to root_url 
      
    end
  end

  def next_step
    
  end
 
  def fetch_booking
    booking_uuid = cookies.signed[:booking_uuid]

    if booking_uuid.present?
      @booking = Booking.find_by(guid: booking_uuid)
    end 
  end

end