class RenameLocationsToGalleries < ActiveRecord::Migration[5.0]
  def change
    rename_table :locations, :galleries
    rename_table :location_photos, :gallery_photos
    rename_column :gallery_photos, :location_id, :gallery_id
  end
end
