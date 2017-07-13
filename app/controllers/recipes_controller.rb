class RecipesController < ApplicationController
  def index
    recipes = Recipe.all
      if recipes.length > 1
        render json: recipes.as_json(except: [:created_at, :updated_at]), status: :ok
      else
        render json: {no_recipes: "Recipes were not found"}, status: :not_found
      end
  end

  def show
    recipe = Recipe.find_by(recipe_id: params[:recipe_id])
    if recipe
      render json:recipe.as_json(except: [:created_at,:updated_at]),status: :ok
    else
      render json: {errors: {recipe_id: ["recipe '#{params[:recipe_id]}' not found"]} }, status: :not_found
    end
  end

end
