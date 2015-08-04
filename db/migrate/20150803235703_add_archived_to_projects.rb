class AddArchivedToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :archived, :boolean, null: false, default: false
  end
end
