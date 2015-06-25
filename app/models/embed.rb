class Embed < ActiveRecord::Base

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :project_id, :user_id, :category_id, :embed_url

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category

  # Embed Methods

  def name
    "EMBED NAME"
  end

end
