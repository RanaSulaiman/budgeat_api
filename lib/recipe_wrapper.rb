require 'httparty'
#require 'recipe'
require 'dotenv/load'

class RecipeWrapper

   BASE_URL = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/'

  def self.getRecipeId

    number_of_recipes = '50'
    url = BASE_URL+ "search" + "?number=" + number_of_recipes + "&type=main course"

    response = HTTParty.get(url,headers: {
      'X-Mashape-Key': ENV['MASHAPE_KEY'],
      'Accept': "application/json"
      }).parsed_response

      return response
  end

  def self.getPricePerServing(recipe_id)

    url = BASE_URL + recipe_id.to_s + '/information?includeNutrition=true'
    response = HTTParty.get(url, headers: {
      'X-Mashape-Key': ENV['MASHAPE_KEY'],
      'Accept': 'application/json'
      }).parsed_response
  end

  def self.getRecipeInformation(recipe_id)
    url = BASE_URL + recipe_id.to_s + '/information?includeNutrition=true'
    response = HTTParty.get(url, headers: {
      'X-Mashape-Key': ENV['MASHAPE_KEY'],
      'Accept': 'application/json'
      }).parsed_response

  end

  def self.showRecipeIdPrice
      getRecipeId['results'].each do |record|
        # puts record['id']
       puts cost = pricePerServing(record['id'])['pricePerServing']
    end
  end

  def self.readRecipeDetails
      getRecipeId['results'].each do |record|
        recipe_details = getRecipeInformation(record['id'])
        args = {
          :recipe_id => record['id'],
          :title => record['title'],
          :image => record['image'],
          :source_uri => record['sourceUrl'],
          :source_name => record['sourceName'],
          :prep_time => record['preparationMinutes'],
          :cook_time => record['cookingMinutes'],
          :ready_time => record['readyInMinutes'],
          :gluten => record['glutenFree'],
          :dairy => record['dairyFree'],
          :vegetarian => record['vegetarian'],
          :vegan => record['vegan'],
          :servings => record['servings'],
          :price_serving => record['pricePerServing'],
          :cuisines => record['cuisines'],
          :dish_type => record['dishTypes'],
          :diets => record['diets'],
          :calories => record['nutrition']['nutrients'][0]['amount'],













        }
        Recipe.create(args)
      end
  end

end

# This is to check the API call in my code when I run in terminal
# recipes = RecipeWrapper.getRecipeId
# recipes = RecipeWrapper.pricePerServing(622084)
# puts recipes

# RecipeWrapper.showRecipeIdPrice
