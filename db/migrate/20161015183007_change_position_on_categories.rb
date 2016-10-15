class ChangePositionOnCategories < ActiveRecord::Migration[5.0]
  def up
    change_column :categories, :position, :integer, null: true, default: nil
  end

  def down
    change_column :categories, :position, :integer, null: false, default: 0
  end
end
