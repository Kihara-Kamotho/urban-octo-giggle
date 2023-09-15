class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart, except: %i[show]

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
    @cart = Cart.find_by(id: session[:cart_id])
  end

  def remove_cart_item
    line_item_id = params[:format]
    line_item = @cart.line_items.find_by(id: line_item_id)
    if line_item
      line_item.destroy
      redirect_to root_path
      flash[:alert] = "Item removed from cart."
    end
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy!
    redirect_to root_path
    flash[:alert] = "Cart has been successfully deleted."
  end

  private

  def cart_params
    params.require(:cart).permit(:amount, :status)
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart#{params[:id]}"
    redirect_to root_path, notice: "Invalid Cart."
  end
end
