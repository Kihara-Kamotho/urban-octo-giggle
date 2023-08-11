class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def index
    @line_items = LineItem.all
  end

  def create
    course = Course.find(params[:course_id])
    @line_item = @cart.add_product(course)

    respond_to do |format|
      if @line_item.save
        flash[:notice] = "Item added to cart."
      end
    end
  end

  def destroy
    @line_item.destroy
  end
end
