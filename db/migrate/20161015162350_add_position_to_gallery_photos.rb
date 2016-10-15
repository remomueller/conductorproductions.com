class AddPositionToGalleryPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :gallery_photos, :position, :integer
  end
end
