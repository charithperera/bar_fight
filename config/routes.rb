Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/", to: "pages#index"

  get "/main", to: "pages#main"
  get "api/getopponents", to: "api/game#opponents"
  post "api/requestbattle", to: "api/game#requestbattle"


  get "/api/collection", to: "api/game#collection"



  get "/signup", to: "session#signup"
  get "/login", to: "session#index"
  get "/beginbattle", to: "game#beginbattle"



  post "/login", to: "session#login"
  post "/logout", to: "session#logout"
  post "/signup", to: "session#create"
  post "/acceptbattle", to: "game#acceptbattle"


end
