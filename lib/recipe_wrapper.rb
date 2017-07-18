require 'httparty'
# require '../app/models/recipe.rb'
require 'dotenv/load'

class RecipeWrapper

  curl_call =  'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?diet=vegetarian&excludeIngredients=coconut&instructionsRequired=false&intolerances=egg%2C+gluten&limitLicense=false&number=10&offset=0&query=burger&type=main+course'


   BASE_URL = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/'

  def self.getRecipeId
    number_of_recipes = 200
    max_recipe_num_call = 100

    calls = number_of_recipes / max_recipe_num_call

    responses = []

    calls.times do |i|
      number = 100


      url = 'https://spoonacular-recipe-food-nutrition-v1.p.mashape.com/recipes/search?instructionsRequired=true&number=100&offset=' + (number*i).to_s
      puts "Iteration #{i}"
      puts "URL: #{url}"

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


    response = Rails.cache.fetch(url, :expires => 1.month) do
      HTTParty.get(url, headers: {
        'X-Mashape-Key': ENV['MASHAPE_KEY'],
        'Accept': 'application/json'
        }).parsed_response
    end
  end


  def self.readRecipeDetails
    # c = (a ||= "xxx")
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

# recipes = RecipeWrapper.getRecipeId
# puts recipes
# recipes = RecipeWrapper.getPricePerServing(622084)
# puts recipes

# RecipeWrapper.showRecipeIdPrice
 # details = RecipeWrapper.readRecipeDetails
 # puts details
