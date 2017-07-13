Rails.application.routes.draw do
  # get 'recipes/index'

  # get "/zomg", to: "recipes#zomg"

    get "/recipes", to:"recipes#index", as: "recipes"
    get "/recipes/:recipe_id", to:"recipes#show", as: "recipe"



end
