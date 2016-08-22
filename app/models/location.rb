# frozen_string_literal: true

# Allows locations to be added to categories.
class Location < ApplicationRecord
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
  has_many :location_photos

  # Location Methods

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    where("locations.slug = ? or locations.id = ?", input.to_s, input.to_i).first
  end
end
