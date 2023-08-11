module CurrentCart
  extend ActiveSupport::Concern

  def set_cart
    @cart = Cart.find_or_create_by(id: session[:cart_id]) do |cart|
      cart.save(validate: false)
    end
    session[:cart_id] = @cart.id
  end
end
