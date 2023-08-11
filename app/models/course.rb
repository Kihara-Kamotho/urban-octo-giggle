class Course < ApplicationRecord
  has_many :sections
  has_many :lessons, through: :sections
  has_and_belongs_to_many :carts

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
