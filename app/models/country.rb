class Country < ApplicationRecord
  has_many :cities
  scope :active, -> {where(active: true)}
end
