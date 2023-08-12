class LineItem < ApplicationRecord
  belongs_to :cart, optional: true
  belongs_to :course
end
