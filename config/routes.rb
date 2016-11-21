Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#index"
  get "/signup", to: "session#signup"

  post "/login", to: "session#login"
  post "/logout", to: "session#logout"
  post "/signup", to: "session#signup"
end
