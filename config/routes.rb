Rails.application.routes.draw do
  get 'page/home'
  get 'page/not_found'
  devise_for :users, path: "", path_names: {sign_in: "login", sign_out: "logout", sign_up: "register"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :listings do
    put :favorite, on: :member
  end

  get "/", to: "pages#home", as: :root
  get "/profile", to: "users#my_profile", as: "user"

  patch "/profile", to: "users#update"
  put  "/profile", to: "users#update"
  get "/profile/edit", to: "users#edit", as: "edit_user"
  
  get "/favorites", to: "listings#show_favorites", as: "show_favorites"
  get "/manage", to: "listings#manage_listings", as: "manage_listings"

  get "/:path", to: "pages#not_found"
  
end
