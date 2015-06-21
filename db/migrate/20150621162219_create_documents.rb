class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.integer :project_id
      t.integer :category_id
      t.integer :user_id
      t.string :document
      t.datetime :document_uploaded_at
      t.boolean :archived, null: false, default: false
      t.boolean :deleted, null: false, default: false

      t.timestamps null: false
    end

    add_index :documents, :project_id
    add_index :documents, :category_id
    add_index :documents, :user_id
    add_index :documents, :archived
    add_index :documents, :deleted
  end
end
