class Course < ApplicationRecord
  has_many :sections
  has_many :lessons, through: :sections
  has_and_belongs_to_many :carts
  has_many :line_items

  validates :title, presence: true, uniqueness: { case_sensitive: false }
end
