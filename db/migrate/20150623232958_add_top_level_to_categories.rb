class AddTopLevelToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :top_level, :string
    add_index :categories, :top_level
  end
end
