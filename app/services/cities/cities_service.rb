module Cities
  class CitiesService
    
    attr_reader :result

    def initialize
      @result = OpenStruct.new(success?: false, city: City.new)
    end

    def list
      City.all
    end

    def new
      
      result
      
    end

    def edit(id)
      find_record(id)
    end

    def create(params)
      result.tap do |r|
        r.city = City.new(params)

        r.send("success?=", r.city.save)
      end
    end

    def update(id, params)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.city.update(params))
      end
    end

    def delete(id)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.city.destroy)
      end
    end

    private

    def find_record(id)
      result.city = City.find(id)
      result
    end

  end
end