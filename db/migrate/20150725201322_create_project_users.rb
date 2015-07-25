class CreateProjectUsers < ActiveRecord::Migration
  def change
    create_table :project_users do |t|
      t.integer :project_id
      t.integer :user_id
      t.boolean :editor
      t.string :invite_token
      t.string :invite_email
      t.integer :creator_id

      t.timestamps null: false
    end

    add_index :project_users, :project_id
    add_index :project_users, :user_id
    add_index :project_users, [:project_id, :user_id]
    add_index :project_users, :invite_token, unique: true
    add_index :project_users, :creator_id
  end
end
