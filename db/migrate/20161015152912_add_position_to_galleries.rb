class AddPositionToGalleries < ActiveRecord::Migration[5.0]
  def change
    add_column :galleries, :position, :integer
    add_index :galleries, :position
  end
end
