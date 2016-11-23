Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"

  get "/main", to: "pages#main"
  get "api/getopponents", to: "api/game#opponents"
  post "/requestbattle", to: "game#requestbattle"
  post "/api/findmatch", to: "api/game#findmatch"
  post "/api/choosecard", to: "api/game#choosecard"
  post "/api/calculatewinner", to: "api/game#calculatewinner"
  post "/clearcurrentgame", to: "game#clearcurrentgame"



  get "/api/collection", to: "api/game#collection"



  get "/signup", to: "session#signup"
  get "/login", to: "session#index"
  get "/beginbattle", to: "game#beginbattle"



  post "/login", to: "session#login"
  post "/logout", to: "session#logout"
  post "/signup", to: "session#create"
  post "/acceptbattle", to: "game#acceptbattle"


end
