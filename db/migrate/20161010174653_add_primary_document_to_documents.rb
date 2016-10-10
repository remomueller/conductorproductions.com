class AddPrimaryDocumentToDocuments < ActiveRecord::Migration[5.0]
  def change
    add_column :documents, :primary_document, :string
  end
end
