class AddUsernameAndPasswordToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :username, :string
    add_column :projects, :password_plain, :string
    add_column :projects, :password_digest, :string

    add_index :projects, :username, unique: true
  end
end
