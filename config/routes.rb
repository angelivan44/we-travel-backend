Rails.application.routes.draw do
  resources :users , :posts ,:departments, :comments , :likes
  post "/login", to: "sessions#create"
  delete "/logout", to: "sessions#destroy"
  post "/user/valid" , to: "users#valid"
  post "user/pin" , to: "users#otp_validation"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
