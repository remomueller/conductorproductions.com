# frozen_string_literal: true

# Allows photos to be added to galleries.
class GalleryPhoto < ApplicationRecord
  # Uploaders
  mount_uploader :photo, ResizableImageUploader

  # Model Validation

  # Model Relationships
  belongs_to :project
  belongs_to :gallery
  belongs_to :user

  # Model Methods

  def number
    gallery.gallery_photos.pluck(:id).index(id) + 1
  rescue
    -1
  end

  def next_photo
    next_index = (gallery.gallery_photos.pluck(:id).index(id) + 1 rescue -1)
    return nil if next_index < 0
    gallery.gallery_photos[next_index]
  end

  def previous_photo
    previous_index = (gallery.gallery_photos.pluck(:id).index(id) - 1 rescue -1)
    return nil if previous_index < 0
    gallery.gallery_photos[previous_index]
  end
end
