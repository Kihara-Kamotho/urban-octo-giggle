Rails.application.routes.draw do
  resources :sections
  devise_for :users
  mount Motor::Admin => "/motor_admin"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"

  resources :courses
end
