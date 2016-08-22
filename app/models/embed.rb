# frozen_string_literal: true

# Allows embeds to be added to categories.
class Embed < ApplicationRecord
  # Concerns
  include Deletable

  # Model Validation
  validates :project_id, :user_id, :category_id, :embed_url, presence: true

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category

  # Embed Methods

  def name
    'EMBED NAME'
  end
end
