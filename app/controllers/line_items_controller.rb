class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @line_items = LineItem.all
  end

  def create
    course = Course.find(params[:course_id])
    @line_item = @cart.add_item_to_cart(course)

    respond_to do |format|
      if @line_item.save
        format.turbo_stream do
          render turbo_stream: turbo_stream.append(:cart, partial: "line_items/line_item", locals: {cart: @cart})
        end
      end
    end
  end

  def destroy
    @line_item.destroy
  end
end
