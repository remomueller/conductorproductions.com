# frozen_string_literal: true

# Name, biography, and videos of directors.
class Director < ApplicationRecord
  # Concerns
  include Deletable
  include Sluggable

  # Uploaders
  mount_uploader :photo, ImageUploader

  # Methods
  def destroy
    update_column :slug, nil
    super
  end

  def videos
    Video.where(video_page: id)
  end
end
