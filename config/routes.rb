Rails.application.routes.draw do
  devise_for :users , :controllers => {registrations: 'registrations'}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
resources :listings
resources :profiles

get "/", to: "listings#index", as: "root"

end
