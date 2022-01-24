class VaccinesItem < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  validates :description, presence: true

  scope :active, -> { where(active: true) }
end
