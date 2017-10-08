# frozen_string_literal: true

# Name, biography, and videos of members.
class Member < ApplicationRecord
  # Concerns
  include Deletable
  include Sluggable
  include Squishable

  squish :name, :title, :nickname

  # Uploaders
  mount_uploader :photo, ImageUploader

  # Validations
  validates :name, :title, presence: true

  # Methods
  def destroy
    update_column :slug, nil
    super
  end

  def videos
    Video.where(video_page: id)
  end
end
