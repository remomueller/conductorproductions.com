# frozen_string_literal: true

# Allows galleries to be added to categories.
class Gallery < ApplicationRecord
  # Concerns
  include Deletable

  # Model Validation
  validates :project_id, :user_id, :category_id, :name, presence: true
  validates :slug, uniqueness: { scope: [:project_id, :deleted] }
  validates :slug, format: { with: /\A[a-z][a-z0-9\-]*\Z/ }

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category
  has_many :gallery_photos, -> { order('position nulls last') }

  # Model Methods

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    where("galleries.slug = ? or galleries.id = ?", input.to_s, input.to_i).first
  end
end
