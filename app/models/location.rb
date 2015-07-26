class Location < ActiveRecord::Base

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :project_id, :user_id, :category_id, :name

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category

  # Location Methods

end
