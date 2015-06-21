class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.string :slug
      t.integer :position, null: false, default: 0
      t.integer :project_id
      t.integer :user_id
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :categories, :position
    add_index :categories, :project_id
    add_index :categories, :user_id
    add_index :categories, :deleted
  end
end
