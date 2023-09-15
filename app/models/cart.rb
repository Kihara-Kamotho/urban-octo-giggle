class Cart < ApplicationRecord
  has_and_belongs_to_many :courses
  has_many :line_items, dependent: :destroy

  def add_item_to_cart(course)
    item = line_items.find_by(course_id: course.id)

    unless item
      item = line_items.build(course_id: course.id)
      save
    end
    item
  end

  def amount
    self.amount = line_items.sum { |item| item.course.price }
  end
end
