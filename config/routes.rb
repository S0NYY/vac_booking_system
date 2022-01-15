Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: "main#index"
    resources :users
    resources :vaccines_items
    resources :bookings
    resources :patients
    resources :business_units
    resources :business_unit_slots
    resources :countries
    resources :cities
    resources :districts
end

  root to: "main#index"

  match 'booking/:vaccine', to: 'main#current_step', via: :get, as: :current_step
  match 'next_step', to: 'main#next_step', via: :post
end
