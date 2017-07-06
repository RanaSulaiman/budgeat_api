class RecipesController < ApplicationController
  def index
    recipes = Recipe.all
      if recipes.length > 1
        render json: recipes.as_json(except: [:created_at, :updated_at]), status: :ok 
      else
        render json: {no_recipes: "Recipes were not found"}, status: :not_found
      end
  end
end
