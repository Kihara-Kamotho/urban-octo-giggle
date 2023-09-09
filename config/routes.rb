Rails.application.routes.draw do
  devise_for :users
  mount Motor::Admin => "/motor_admin"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  root "courses#index"

  resources :courses do
    resources :sections, shallow: true do
      resources :lessons
    end
  end

  resources :carts, only: %i[destroy]
  get "/cart", to: "carts#show"
  delete "/cart", to: "carts#destroy"
  delete "/remove_item", to: "carts#remove_cart_item"
  resources :line_items
  resources :checkouts, only: %i[create]
  get "/checkout", to: "checkouts#checkout"
end
