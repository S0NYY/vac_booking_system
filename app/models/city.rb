class City < ApplicationRecord
  belongs_to :country

  scope :by_country, ->(country_id) { where(country_id: country_id, active: true) }
  scope :active, -> { where(active: true) }
end
