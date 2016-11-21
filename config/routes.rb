Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#index"
  get "/signup", to: "session#signup"
  get "/login", to: "session#index"
  get "/collection", to: "game#collection"
  get "/opponents", to: "game#opponents"
  get "/requestbattle", to: "game#requestbattle"
  get "/beginbattle", to: "game#beginbattle"



  post "/login", to: "session#login"
  post "/logout", to: "session#logout"
  post "/signup", to: "session#create"
  post "/acceptbattle", to: "game#acceptbattle"


end
