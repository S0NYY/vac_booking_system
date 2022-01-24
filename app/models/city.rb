class City < ApplicationRecord
  belongs_to :country

  scope :by_country, ->(country_id) { where(country_id: country_id) }
  scope :active, -> { where(active: true) }
end
