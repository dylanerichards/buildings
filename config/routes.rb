Rails.application.routes.draw do
  devise_for :clients
  get 'pages/home'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  post "/buildings", to: "buildings#create"
  patch "/buildings/:id", to: "buildings#update"
end
