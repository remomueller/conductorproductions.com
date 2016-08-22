class ChangeLogoToAgencyLogo < ActiveRecord::Migration[4.2]
  def change
    rename_column :projects, :logo, :agency_logo
  end
end
