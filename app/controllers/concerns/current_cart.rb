module CurrentCart
  extend ActiveSupport::Concern

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
    if @cart.nil?
      @cart = Cart.create
      session[:cart_id] = @cart.id
      session[:cart_count] = 0
    end
  end
end
