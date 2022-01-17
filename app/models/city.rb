class City < ApplicationRecord
  belongs_to :country

  scope :active, -> {where(active: true)}
  
  scope :by_country, -> (country_id) { where(country_id: country_id, active: true) }
end
