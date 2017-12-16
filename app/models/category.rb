# frozen_string_literal: true

# Provides folders for galleries, embeds, and documents.
class Category < ApplicationRecord
  # Concerns
  include Deletable

  # Model Validation
  validates :top_level, :name, :slug, presence: true
  validates :slug, uniqueness: { scope: [:project_id, :deleted] }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Model Relationships
  belongs_to :project
  belongs_to :user

  # Category Methods
  has_many :documents, -> { current.order(:archived, document_uploaded_at: :desc) }
  has_many :embeds, -> { current.order(:archived) }
  has_many :galleries, -> { current.order(:archived, Arel.sql("position nulls last")) }

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    find_by("categories.slug = ? or categories.id = ?", input.to_s, input.to_i)
  end

  def pdf_documents
    documents.where("documents.document LIKE '%.pdf'")
  end

  def show_menu?
    documents.count + embeds.count + galleries.count > 0
  end
end
