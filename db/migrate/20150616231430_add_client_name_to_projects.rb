class AddClientNameToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :client_name, :string
  end
end
