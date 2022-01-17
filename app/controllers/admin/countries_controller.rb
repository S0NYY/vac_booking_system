module Admin
  class CountriesController < ApplicationController
    before_action :init_service
    
    def index
      @pagy, @countries = pagy(@countries_service.list)
    end

    def new
      result = @countries_service.new
      @country = result.country
      
    end

    def edit
      result = @countries_service.edit(params[:id])

      @country = result.country
    end


    def create
      result = @countries_service.create(country_params)
      @country = result.country

      if result.success?
        redirect_to admin_countries_path, notice: I18n.t('admin.countries.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @countries_service.update(params[:id], country_params)
      @country = result.country

      if result.success?
        redirect_to admin_countries_path, notice: I18n.t('admin.countries.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @countries_service.delete(params[:id])
      
      if result.success?
        redirect_to admin_countries_path, notice: I18n.t('admin.countries.notices.destroyed')
      end
    end

    def fetch_cities
      @cities = City.by_country(params[:country_id])

      render partial: 'cities', object: @cities, layout: false
    end

    private 

    def init_service
      @countries_service = Countries::CountriesService.new
    end

    def country_params
      params.require(:country).permit(:name, :code, :active)
    end
  end
end