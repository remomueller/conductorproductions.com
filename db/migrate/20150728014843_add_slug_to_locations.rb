class AddSlugToLocations < ActiveRecord::Migration[4.2]
  def change
    add_column :locations, :slug, :string
  end
end
