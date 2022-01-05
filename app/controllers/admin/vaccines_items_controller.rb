module Admin
  class VaccinesItemsController < ApplicationController
    before_action :init_service

    def index
     @pagy, @vaccines = pagy(@vaccine_service.list)
    end

    def new
      result = @vaccine_service.new

      @vaccine = result.vaccine
    end

    def edit
      result = @vaccine_service.edit(params[:id])

      @vaccine = result.vaccine
    end

    def create
      result = @vaccine_service.create(create_vaccine_params)
      @vaccine = result.vaccine

      if result.success?
        redirect_to admin_vaccines_items_path, notice: I18n.t('admin.vaccines.notices.created')
      else
        render :new, status: :unprocessable_entity
      end
    end

    def update
      result = @vaccine_service.update(params[:id], create_vaccine_params)
      @vaccine = result.vaccine

      if result.success?
        redirect_to admin_vaccines_items_path, notice: I18n.t('admin.vaccines.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    def destroy
      result = @vaccine_service.delete(params[:id])
      
      if result.success?
        redirect_to admin_vaccines_items_path, notice: I18n.t('admin.vaccines.notices.destroyed')
      end
    end

    private

    def init_service
      @vaccine_service = Vaccines::VaccineService.new(@current_user)
    end

    def create_vaccine_params
      params.require(:vaccines_item).permit(:name, :active)
    end

    def update_vaccine_params
      params.require(:vaccine).permit(:id, :name, :active)
    end

  end
end