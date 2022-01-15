module Admin
  class BusinessUnitsController < ApplicationController
    before_action :init_service

    def index
      @pagy, @units = pagy(@business_units.list)
    end

    def new
      result = @business_units.new
      @unit = result.unit
    end

    def edit
      result = @business_units.edit(params[:id])

      @unit = result.unit
    end

    def create
      
      result = @business_units.create(unit_params)
      @unit = result.unit

      if result.success?
        redirect_to admin_business_units_path, notice: I18n.t('admin.countries.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @business_units.update(params[:id], unit_params)
      @unit = result.unit

      if result.success?
        redirect_to admin_business_units_path, notice: I18n.t('admin.countries.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @business_units.delete(params[:id])
      
      if result.success?
        redirect_to admin_business_units_path, notice: I18n.t('admin.countries.notices.destroyed')
      end
    end

    private

    def init_service
      @business_units = Units::UnitsService.new
    end

    def unit_params
      params.require(:business_unit).permit(:id, :country_id, :city_id, :district_id, :name, :code, :active)
    end
  end
end