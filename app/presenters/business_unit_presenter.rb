# ...
class BusinessUnitPresenter < Struct.new(:business_unit)
  def id
    business_unit&.id
  end

  def country_id
    business_unit&.country_id
  end

  def country_name
    business_unit&.country&.name
  end

  def city_id
    business_unit&.city_id
  end

  def city_name
    business_unit&.city&.name
  end

  def district_id
    business_unit&.district_id
  end

  def district_name
    business_unit&.district&.name
  end
end
