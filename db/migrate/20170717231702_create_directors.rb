class CreateDirectors < ActiveRecord::Migration[5.1]
  def change
    create_table :directors do |t|
      t.string :name
      t.string :slug
      t.text :biography
      t.string :photo
      t.integer :position
      t.boolean :archived, null: false, default: false
      t.boolean :deleted, null: false, default: false
      t.index :slug, unique: true
      t.index :position
      t.index :archived
      t.index :deleted
      t.timestamps
    end
  end
end
