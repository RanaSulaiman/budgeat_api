Rails.application.routes.draw do

    get "/recipes", to:"recipes#index", as: "recipes"
    get "/recipes/:recipe_id", to:"recipes#show", as: "recipe"

end
