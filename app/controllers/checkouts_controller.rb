class CheckoutsController < ApplicationController
  def checkout
    # get the checkout form
  end

  def create

  end

  private

  def checkout_params
    params.require(:checkout).permit(:phone, :payment_method)
  end
end
