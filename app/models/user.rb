class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :full_name, :email, presence: true

  def self.search(full_name)
    if full_name
      where(["full_name LIKE ?", "%#{full_name}%"])
    else
      all
    end
  end
end
