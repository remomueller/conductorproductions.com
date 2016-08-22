class AddNumberToProjects < ActiveRecord::Migration[4.2]
  def change
    add_column :projects, :number, :string
  end
end
