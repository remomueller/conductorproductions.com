class ChangePageToVideoPage < ActiveRecord::Migration
  def change
    rename_column :videos, :page, :video_page
  end
end
