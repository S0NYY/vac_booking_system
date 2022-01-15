module Admin
  class DistrictsController < ApplicationController
    before_action :init_service
    
    def index
      @pagy, @districts = pagy(@districts_service.list)
    end

    def new
      result = @districts_service.new
      @district = result.district
      
    end

    def edit
      result = @districts_service.edit(params[:id])

      @district = result.district
    end


    def create
      result = @districts_service.create(district_params)
      @district = result.district

      if result.success?
        redirect_to admin_districts_path, notice: I18n.t('admin.slots.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @districts_service.update(params[:id], district_params)
      @district = result.district

      if result.success?
        redirect_to admin_districts_path, notice: I18n.t('admin.users.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @districts_service.delete(params[:id])
      
      if result.success?
        redirect_to admin_districts_path, notice: I18n.t('admin.users.notices.destroyed')
      end
    end

    private 

    def init_service
      @districts_service = Districts::DistrictsService.new
    end

    def district_params
      params.require(:district).permit(:city_id, :name, :code, :active)
    end
  end
end