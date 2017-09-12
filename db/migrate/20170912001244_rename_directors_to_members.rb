class RenameDirectorsToMembers < ActiveRecord::Migration[5.1]
  def change
    rename_table :directors, :members
  end
end
