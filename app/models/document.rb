class Document < ActiveRecord::Base

  # Uploaders
  mount_uploader :document, DocumentUploader

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :project_id, :user_id, :category_id, :document

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category

  # Document Methods

  def name
    self.document_identifier
  end

  def pdf?
    self.document_identifier.last(4).to_s.downcase == '.pdf'
  end

end
