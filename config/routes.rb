Rails.application.routes.draw do
  devise_for :users
  mount Motor::Admin => "/motor_admin"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "courses#index"

  resources :courses do
    resources :sections, shallow: true do
      resources :lessons
    end
  end

  resources :carts, only: %i[create destroy]
  resources :line_items

  resources :checkouts, only: %i[create]
  get '/checkout', to: 'checkouts#checkout'
end
