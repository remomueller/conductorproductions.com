# frozen_string_literal: true

# Allows documents to be attached to categories.
class Document < ApplicationRecord
  # Uploaders
  mount_uploader :document, DocumentUploader

  # Concerns
  include Deletable

  # Model Validation
  validates :project_id, :user_id, :category_id, :document, presence: true

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category

  # Document Methods

  def name
    document_identifier
  end

  def pdf?
    document_identifier.last(4).to_s.downcase == '.pdf'
  end

  def image?
    document_identifier.last(4).to_s.downcase == '.png'
  end
end
