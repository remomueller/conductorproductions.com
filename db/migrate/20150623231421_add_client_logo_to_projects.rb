class AddClientLogoToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :client_logo, :string
  end
end
