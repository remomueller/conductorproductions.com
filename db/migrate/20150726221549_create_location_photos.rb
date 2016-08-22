class CreateLocationPhotos < ActiveRecord::Migration[4.2]
  def change
    create_table :location_photos do |t|
      t.integer :project_id
      t.integer :location_id
      t.integer :user_id
      t.string :photo

      t.timestamps null: false
    end

    add_index :location_photos, :project_id
    add_index :location_photos, :location_id
    add_index :location_photos, :user_id
  end
end
