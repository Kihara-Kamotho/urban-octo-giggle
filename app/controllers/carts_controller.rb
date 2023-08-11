class CartsController < ApplicationController
  before_action :set_cart
  rescue_from ActiveRecord::RecordNotFound, with: :invalid_cart

  def Create
    @cart = Cart.create(cart_params)
  end

  def destroy
    cart = Cart.find(params[:id])
    cart.destroy
  end

  private

  def set_cart
    @cart = Cart.find(params[:id])
  end

  def cart_params
    params.require(:cart).permit(:amount, :status)
  end

  def invalid_cart
    logger.error "Attempt to access invalid cart#{params[:id]}"
    redirect_to root_path, notice: "Invalid Cart."
  end
end