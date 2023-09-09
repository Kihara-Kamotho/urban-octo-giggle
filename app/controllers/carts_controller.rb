class CartsController < ApplicationController
  include CurrentCart
  before_action :set_cart

  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def show
  end

  def remove_cart_item
    line_item_id = params[:format]
    @cart.remove_item_from_cart(line_item_id)
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
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
