Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

#welcome screen
  get "/", to: "pages#index"

#login
  get "/signup", to: "session#signup"
  get "/login", to: "session#index"

#after login, redirected to pages
  get "/main", to: "pages#main"

#main display: collection, new game, stats
#new collection
  get "/api/collection", to: "api/game#collection"

#new game - let's see online opponents
  get "/api/opponents", to: "api/game#opponents"

#need to create api entries for the above

  post "/api/requestbattle", to: "api/game#requestbattle"

  get "/beginbattle", to: "game#beginbattle"


  post "/login", to: "session#login"
  post "/logout", to: "session#logout"
  post "/signup", to: "session#create"
  post "/acceptbattle", to: "game#acceptbattle"


end
