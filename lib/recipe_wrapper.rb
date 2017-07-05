require 'httparty'
#require 'recipe'
require 'dotenv/load'

class RecipeWrapper

   BASE_URL = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/'

  def self.getRecipeId

    number_of_recipes = '20'
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
          :ready_in_minutes => record['readyInMinutes'],
          :image => record['image'],
          :price_per_serving => recipe_details['pricePerServing']
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
