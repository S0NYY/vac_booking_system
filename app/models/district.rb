class District < ApplicationRecord
  has_many :city

  scope :active, -> {where(active: true)}
  scope :by_city, -> (city_id) { where(city_id: city_id, active: true) }

end
