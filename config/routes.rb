Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: "main#index"
    resources :users
    resources :vaccines_items
    resources :bookings
  end

  root to: "main#index"

  match 'booking/:vaccine', to: 'main#current_step', via: :get, as: :new_booking
  match 'next_step', to: 'main#next_step', via: :post
end
