Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "pages#index"

  get "/main", to: "pages#main"
  post "/api/findmatch", to: "api/game#findmatch"
  post "/api/choosecard", to: "api/game#choosecard"
  post "/api/calculatewinner", to: "api/game#calculatewinner"
  get "/api/getcollection", to: "api/game#getcollection"
  get "/api/getstats", to: "api/game#getstats"
  post "/clearall", to: "game#clearall"
  get "/signup", to: "session#signup"
  get "/login", to: "session#index"
  post "/login", to: "session#login"
  post "/logout", to: "session#logout"
  post "/signup", to: "session#create"
end
