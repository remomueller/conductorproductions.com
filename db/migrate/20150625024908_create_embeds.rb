class CreateEmbeds < ActiveRecord::Migration[4.2]
  def change
    create_table :embeds do |t|
      t.integer :project_id
      t.integer :category_id
      t.integer :user_id
      t.text :embed_url
      t.boolean :archived, null: false, default: false
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :embeds, :project_id
    add_index :embeds, :category_id
    add_index :embeds, :user_id
    add_index :embeds, :archived
    add_index :embeds, :deleted
  end
end
