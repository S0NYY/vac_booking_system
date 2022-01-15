module Patients
  class PatientsService 

    attr_reader :result

    def initialize
      
      @result = OpenStruct.new(success?: false, patient: Patient.new)
    end 

    def list
      Patient.all
    end

    def show(id)
      find_record(id)
    end

    def edit(id)
      find_record(id)
    end

    def update(id, params)
      find_record(id)

      result.tap do |r|
        r.send("success?=", r.patient.update(params))
      end
    end

    private

    def find_record(id)
      result.patient = Patient.find(id)
      result
    end
  end
end