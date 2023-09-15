class LineItemsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  def create
    course = Course.find(params[:course_id])
    @line_item = @cart.add_item_to_cart(course)

    respond_to do |format|
      if @line_item.save
        session[:cart_count] = @cart.line_items.length

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
