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

  def number
    self.location.location_photos.pluck(:id).index(self.id) + 1 rescue -1
  end

  def next_photo
    next_index = (self.location.location_photos.pluck(:id).index(self.id) + 1 rescue -1)
    return nil if next_index < 0
    self.location.location_photos[next_index]
  end

  def previous_photo
    previous_index = (self.location.location_photos.pluck(:id).index(self.id) - 1 rescue -1)
    return nil if previous_index < 0
    self.location.location_photos[previous_index]
  end

end
