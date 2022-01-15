module Admin
  class PatientsController < ApplicationController

    before_action :init_service

    def index
      @pagy, @patients = pagy(@patient_service.list)

    end

    def show
      result = @patient_service.show(params[:id])

      @patient = result.patient
    end

    def edit
      result = @patient_service.edit(params[:id])

      @patient = result.patient
    end

    def update
      result = @patient_service.update(params[:id], patient_params)
      @user = result.patient

      if result.success?
        redirect_to admin_patients_path, notice: I18n.t('admin.patients.notices.updated')
      else
        render :edit, status: :unprocessable_entity
      end
    end

    private

    def init_service
      @patient_service = Patients::PatientsService.new
    end

    def patient_params
      params.require(:patient).permit(:mobile_phone)
    end
  end
end