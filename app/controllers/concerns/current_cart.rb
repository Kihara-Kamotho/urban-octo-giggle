module CurrentCart
  extend ActiveSupport::Concern

  def set_cart
    @cart = Cart.find_by(session[:cart_id])
    rescue ActiveRecord::RecordNotFound
      @cart = Cart.create
      session[:cart_id] = @cart.id
  end
end
