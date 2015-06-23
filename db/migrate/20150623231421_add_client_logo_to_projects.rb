class AddClientLogoToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :client_logo, :string
  end
end
