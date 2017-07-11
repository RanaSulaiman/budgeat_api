class AddRemoveRenameColumns < ActiveRecord::Migration[5.0]
  def change
    rename_column :recipes, :source_uri, :source_url
    remove_column :recipes, :calories
    add_column :recipes, :instructions, :string
    add_column :recipes, :weightWatcherSmartPoints, :integer

  end
end
