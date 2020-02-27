Rails.application.routes.draw do
  get 'page/home'
  get 'page/not_found'
  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :listings
  get "/", to: "pages#home", as: :root
  get "/profile", to: "users#my_profile", as: :profile

  get "/:path", to: "pages#not_found"
  
end
