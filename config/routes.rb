Rails.application.routes.draw do
  devise_for :clients

  get 'pages/home'

  post "/buildings", to: "buildings#create"
  patch "/buildings/:id", to: "buildings#update"
  get "/buildings", to: "buildings#index"

  patch "/custom_fields", to: "custom_fields#update"
end
