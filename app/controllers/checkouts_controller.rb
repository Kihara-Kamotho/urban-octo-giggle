class CheckoutsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def checkout
    # get the checkout form
    @payment_methods = ["mpesa", "card"]
  end

  def create
  end

  private

  def checkout_params
    params.require(:checkout).permit(:phone, :payment_method)
  end
end
