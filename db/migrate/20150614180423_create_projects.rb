class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.string :slug
      t.string :logo
      t.integer :user_id
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end
  end
end
