module CurrentCart
  extend ActiveSupport::Concern

  def set_cart
    @cart = Cart.find_by(id: session[:cart_id])
    if @cart.nil?
      session[:cart_count] = 0
      @cart = Cart.create
      session[:cart_id] = @cart.id
    end
  end
end
