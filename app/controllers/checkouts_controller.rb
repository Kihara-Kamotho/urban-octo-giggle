class CheckoutsController < ApplicationController
  include CurrentCart
  before_action :set_cart
  def checkout
    # get the checkout form
    @payment_methods = ["mpesa", "card"]
  end

  def create
    phone = params[:phone]
    payment_method = params[:payment_method]
    amount = @cart.amount
    if payment_method === "mpesa"
      MpesaStk::PushPayment.call(amount, phone)
    end
    # pay, successfully
    # create a new subscription
  end

  private

  def checkout_params
    params.require(:checkout).permit(:phone, :payment_method)
  end
end
