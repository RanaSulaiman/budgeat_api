class CreateRecipes < ActiveRecord::Migration[5.0]
  def change
    create_table :recipes do |t|
      t.string :recipe_id
      t.string :title
      t.string :image
      t.string :source_uri
      t.string :source_name
      t.integer :prep_time
      t.integer :cook_time
      t.integer :ready_time
      t.string :gluten
      t.string :dairy
      t.string :vegetarian
      t.string :vegan
      t.integer :servings
      t.float :price_serving
      t.string :cuisines
      t.string :dish_type
      t.string :diets
      t.integer :calories


















      t.integer :ready_in_minutes
      t.string :image
      t.float :price_per_serving



      t.timestamps
    end
  end
end
