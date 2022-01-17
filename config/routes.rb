Rails.application.routes.draw do

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
  
  root to: "main#index"

  devise_for :users
    
    namespace :admin do
      root to: "main#index"
      resources :users
      resources :vaccines_items
      resources :bookings
      resources :patients
      resources :business_units
      resources :business_unit_slots
      resources :districts
      
      get "/countries/fetch_cities"
      resources :countries
      
      get "/cities/fetch_districts"
      resources :cities
    end
    
  end
    match 'booking/:vaccine', to: 'main#current_step', via: :get, as: :current_step
    match 'next_step', to: 'main#next_step', via: :post
    
end
