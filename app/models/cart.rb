class Cart < ApplicationRecord
  has_and_belongs_to_many :courses
  has_many :line_items, dependent: :destroy

  def add_product(course)
    item = line_items.find_by(course_id: course.id)
    if item
      item.quantity += 1
    else
      line_items.build(course_id: course.id)
    end
  end

  def reduce_quantity(course)
    item = line_items.find_by(course_id: course.id)
    if item
      item.quantity -= 1
    end
  end
end
