class AddNumberToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :number, :string
  end
end
