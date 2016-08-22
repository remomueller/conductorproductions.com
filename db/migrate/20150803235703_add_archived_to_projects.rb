class AddArchivedToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :archived, :boolean, null: false, default: false
  end
end
