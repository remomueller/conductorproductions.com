class LocationPhoto < ActiveRecord::Base

  # Uploaders
  mount_uploader :photo, ResizableImageUploader

  # Model Validation
  validates_presence_of :project_id, :location_id, :user_id

  # Model Relationships
  belongs_to :project
  belongs_to :location
  belongs_to :user

  # Location Photo Methods

end
