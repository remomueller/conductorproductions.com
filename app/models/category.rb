# frozen_string_literal: true

# Provides folders for locations, embeds, and documents.
class Category < ActiveRecord::Base
  # Concerns
  include Deletable

  # Model Validation
  validates :top_level, :name, :slug, :position, :project_id, :user_id, presence: true
  validates :slug, uniqueness: { scope: [:project_id, :deleted] }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Model Relationships
  belongs_to :project
  belongs_to :user

  # Category Methods
  has_many :documents, -> { where(deleted: false).order(:archived) }
  has_many :embeds, -> { where(deleted: false).order(:archived) }
  has_many :locations, -> { where(deleted: false).order(:archived) }

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    where('categories.slug = ? or categories.id = ?', input.to_s, input.to_i).first
  end

  def pdf_documents
    documents.where("documents.document LIKE '%.pdf'")
  end

  def show_menu?
    documents.count + embeds.count + locations.count > 0
  end
end
