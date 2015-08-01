class CreateVideos < ActiveRecord::Migration
  def change
    create_table :videos do |t|
      t.integer :user_id
      t.string :page
      t.string :photo
      t.integer :vimeo_number
      t.integer :position, null: false, default: 0
      t.boolean :archived, null: false, default: false
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :videos, :user_id
    add_index :videos, :page
  end
end
