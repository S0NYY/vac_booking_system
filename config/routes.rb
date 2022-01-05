Rails.application.routes.draw do
  devise_for :users

  namespace :admin do
    root to: "main#index"
    resources :users
    resources :vaccines_items
  end
end
