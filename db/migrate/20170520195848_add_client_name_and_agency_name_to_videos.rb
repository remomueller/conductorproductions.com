class AddClientNameAndAgencyNameToVideos < ActiveRecord::Migration[5.1]
  def change
    add_column :videos, :client_name, :string
    add_column :videos, :agency_name, :string
  end
end
