class SlotsController < ApplicationController
  before_action do
    @dt = params[:dt]
  end

  def index
    @bu_unit = BusinessUnit.find(params[:business_unit_id])

    @bu_unit_slot = BusinessUnitSlot.active

    slots = Slots::SqlService.new(@bu_unit.business_unit_slots.active).slots

    @bu_slots = slots.group_by { |r| [r.current_start_date, r.duration] }
  end

  def fetch_cities
    @cities = City.active.where(country_id: params[:country_id])

    render partial: 'cities', object: @cities, locals: { dt: @dt }, layout: false
  end

  def fetch_districts
    @districts = District.active.where(city_id: params[:city_id])

    render partial: 'districts', object: @districts, locals: { dt: @dt }, layout: false
  end

  def fetch_business_units
    @bu_units = BusinessUnit.active.where(
      country_id: params[:country_id],
      city_id: params[:city_id],
      district_id: params[:district_id]
    )

    render partial: 'bu_units', object: @bu_units, locals: { dt: @dt }, layout: false
  end
end
