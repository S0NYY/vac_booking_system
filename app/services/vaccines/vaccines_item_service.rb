module Vaccines
  # ...
  class VaccinesItemService
    attr_reader :current_user, :result

    def initialize(current_user)
      @current_user = current_user
      @result = OpenStruct.new(success?: false, vaccine: VaccinesItem.new)
    end

    def list
      VaccinesItem.all
    end

    def new
      result
    end

    def edit(id)
      find_record(id)
    end

    def create(params)
      result.tap do |r|
        r.vaccine = VaccinesItem.new(params)
        r.send('success?=', r.vaccine.save)
      end
    end

    def update(id, params)
      find_record(id)

      result.tap do |r|
        r.send('success?=', r.vaccine.update(params))
      end
    end

    def delete(id)
      find_record(id)

      result.tap do |r|
        r.send('success?=', r.vaccine.destroy)
      end
    end

    private

    def find_record(id)
      result.vaccine = VaccinesItem.find(id)
      result
    end
  end
end
