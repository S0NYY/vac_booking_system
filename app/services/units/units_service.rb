module Units
  class UnitsService
    attr_reader :result

    def initialize
      @result = OpenStruct.new(success?: false, unit: BusinessUnit.new)
    end


    def list
      BusinessUnit.all
    end

    def new
      result
    end

    def edit(id)
      find_record(id)
    end

    def create(params)
      result.tap do |r|
        r.unit = BusinessUnit.new(params)
        r.send("success?=", r.unit.save)
      end
    end

    def update(id, params)
      find_record(id)
      result.tap do |r|
        r.send("success?=", r.unit.update(params))
      end
    end

    def delete(id)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.unit.destroy)
      end
    end


    private

    def find_record(id)
      result.unit = BusinessUnit.find(id)
      result
    end
  end
end