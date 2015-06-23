class ChangeLogoToAgencyLogo < ActiveRecord::Migration
  def change
    rename_column :projects, :logo, :agency_logo
  end
end
