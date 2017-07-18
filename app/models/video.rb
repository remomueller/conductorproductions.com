# frozen_string_literal: true

# Specifies videos that are added to Work or DRTV pages.
class Video < ApplicationRecord
  # Uploaders
  mount_uploader :photo, VideoImageUploader

  # Constants
  PAGES = [%w[HOME home], %w[WORK work], %w[DRTV drtv]]

  # Concerns
  include Deletable

  # Model Validation
  validates :video_page, :vimeo_number, :photo, :position, :user_id, presence: true
  # validates :video_page, inclusion: { in: PAGES.collect(&:second) }
  validates :vimeo_number, uniqueness: { scope: [:deleted, :video_page] }
  # validates :vimeo_number, numericality: { greater_than_or_equal_to: 0 }
  validates :position, numericality: { greater_than_or_equal_to: 0 }

  # Model Relationships
  belongs_to :user

  # Model Methods

  def name
    photo_identifier
  end

  def video_page_string
    item = PAGES.find { |_name, value| value == video_page }
    director = Director.find_by(id: video_page)
    if item
      item[0]
    elsif director
      director.name
    else
      ""
    end
  end
end
