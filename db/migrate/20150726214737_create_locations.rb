class CreateLocations < ActiveRecord::Migration[4.2]
  def change
    create_table :locations do |t|
      t.integer :project_id
      t.integer :category_id
      t.integer :user_id
      t.string :name
      t.text :address
      t.boolean :archived
      t.boolean :deleted

      t.timestamps null: false
    end

    add_index :locations, :project_id
    add_index :locations, :category_id
    add_index :locations, :user_id
    add_index :locations, :archived
    add_index :locations, :deleted
  end
end
