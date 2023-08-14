class Cart < ApplicationRecord
  has_and_belongs_to_many :courses
  has_many :line_items, dependent: :destroy

  def add_item_to_cart(course)
    item = line_items.find_by(course_id: course.id)
    binding.irb
    unless item
      line_items.build(course_id: course.id)
    end
    item
  end

  def amount
    line_items.sum { |item| item.course.price }
  end
end
