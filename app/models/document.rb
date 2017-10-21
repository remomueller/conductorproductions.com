# frozen_string_literal: true

# Allows documents to be attached to categories.
class Document < ApplicationRecord
  # Uploaders
  mount_uploader :primary_document, PrimaryDocumentUploader
  mount_uploader :document, DocumentUploader

  # Concerns
  include Deletable

  # Model Validation
  validates :primary_document, presence: true

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category

  # Document Methods

  def name
    primary_document_identifier || document_identifier
  end

  def name_secondary
    document_identifier
  end

  def pdf?
    return false unless primary_document.present?
    primary_extension == 'PDF'
  end

  def image?
    return false unless primary_document.present?
    primary_extension == 'PNG'
  end

  def primary_extension
    primary_document.file.extension.to_s.upcase
  end

  def secondary_extension
    document.file.extension.to_s.upcase
  end
end
