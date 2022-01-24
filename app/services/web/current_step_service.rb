module Web
  # ...
  class CurrentStepService
    include Interactor
    before :check_vaccine

    before do
      context._step = Web::StepsWrapper.call(booking: context.booking, params: context.params)
    end

    def call
      prepare_current_step
      create_booking! if context.booking.blank?
      fetch_current_step
    end

    private

    def check_vaccine
      context.selected_vaccine = fetch_curent_vaccine

      if context.selected_vaccine.blank?
        context.fail!(message: I18n.t('web.main.no_vaccine'))
      else
        context.booking = nil if context.booking&.vaccine && context.selected_vaccine.name != context.booking.vaccine.name
      end
    end

    def fetch_curent_vaccine
      name = context.params[:vaccine]&.downcase

      return nil unless name

      VaccinesItem.active.where('lower(name) = ?', name).take
    end

    def create_booking!
      context.booking = Booking.create(
        guid: SecureRandom.uuid,
        vaccine_id: context.current_vaccine.id,
        ip_address: context.collect_analytics[:user_ip],
        browser_name: context.collect_analytics[:browser],
        os_name:context.collect_analytics[:platform]
      )
    rescue => e
      context.fail!(message: e)
    end

    def fetch_current_step
      context.render_step = context._step.step_number
    end

    def prepare_current_step
      context.record = context._step.record
      context.current_vaccine = context.booking&.vaccine || context.selected_vaccine
    end
  end
end
