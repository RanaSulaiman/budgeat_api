require 'httparty'
# require '../app/models/recipe.rb'
require 'dotenv/load'

class RecipeWrapper

   BASE_URL = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/'

  def self.getRecipeId

    number_of_recipes = '20'

    url = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?instructionsRequired=true&cuisines=indian%2C+chinese%2C+african%2C+italian%2C+middle eastern%2C+mexican%2C+american&number=20'

    response = HTTParty.get(url,headers: {
      'X-Mashape-Key': ENV['MASHAPE_KEY'],
      'Accept': "application/json"
      }).parsed_response

      return response
  end

  def self.getPricePerServing(recipe_id)

    curl =  'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/479101/information?includeNutrition=false'


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
      puts cost = getPricePerServing(record['id'])['pricePerServing']
    end
  end

  def self.readRecipeDetails
    c = (a ||= "xxx")
      getRecipeId['results'].each do |record|
        extra_detail = getRecipeInformation(record['id'])
        args = {
          :recipe_id => record['id'],
          :title => record['title'],
          :image => extra_detail['image'],
          :source_url => extra_detail['sourceUrl'],
          :source_name => extra_detail['sourceName'],
          :prep_time => extra_detail['preparationMinutes'],
          :cook_time => extra_detail['cookingMinutes'],
          :ready_time => record['readyInMinutes'],
          :gluten => extra_detail['glutenFree'],
          :dairy => extra_detail['dairyFree'],
          :vegetarian => extra_detail['vegetarian'],
          :vegan => extra_detail['vegan'],
          :servings => extra_detail['servings'],
          :price_serving => extra_detail['pricePerServing'],
          :cuisines => extra_detail['cuisines'],
          :dish_type => extra_detail['dishTypes'],
          :diets => extra_detail['diets'],
          :instructions => extra_detail['instructions'],
          :weightWatcherSmartPoints => extra_detail['weightWatcherSmartPoints']

        }
        Recipe.create(args)
      end
  end

end

# recipes = RecipeWrapper.getRecipeId
# puts recipes
# recipes = RecipeWrapper.getPricePerServing(622084)
# puts recipes

# RecipeWrapper.showRecipeIdPrice
 # details = RecipeWrapper.readRecipeDetails
 # puts details
