class ChangePageToVideoPage < ActiveRecord::Migration[4.2]
  def change
    rename_column :videos, :page, :video_page
  end
end
