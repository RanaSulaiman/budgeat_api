require 'httparty'
# require '../app/models/recipe.rb'
# require 'dotenv/load'

class RecipeWrapper

   BASE_URL = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/'

  def self.getRecipeId
    number_of_recipes = 500
    max_recipe_num_call = 100

    calls = number_of_recipes / max_recipe_num_call

    responses = []

    calls.times do |i|
      url = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?instructionsRequired=true&number=100&offset=' + (max_recipe_num_call*i).to_s

      response = HTTParty.get(url,headers: {
         'X-Mashape-Key': ENV['MASHAPE_KEY'],
         'Accept': "application/json"
         }).parsed_response
       responses << response
    end

    return responses

  end


  def self.getRecipeInformation(recipe_id)

    url = BASE_URL + recipe_id.to_s + '/information?includeNutrition=true'

  #Implementing memcached to speed up the API calls
    response = Rails.cache.fetch(url, :expires => 1.month) do
      HTTParty.get(url, headers: {
        'X-Mashape-Key': ENV['MASHAPE_KEY'],
        'Accept': 'application/json'
        }).parsed_response
    end
  end


  def self.readRecipeDetails
      responses = getRecipeId

      responses.each do |response|
        response['results'].each do |record|
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
end
