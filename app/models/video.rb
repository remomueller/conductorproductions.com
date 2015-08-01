class Video < ActiveRecord::Base

  # Uploaders
  mount_uploader :photo, VideoImageUploader

  # Constants
  PAGES = [['WORK', 'work'],['DRTV', 'drtv']]

  # Concerns
  include Deletable

  # Named Scopes

  # Model Validation
  validates_presence_of :video_page, :vimeo_number, :photo, :position, :user_id
  validates_inclusion_of :video_page, in: %w( work drtv )
  validates_uniqueness_of :vimeo_number, scope: [ :deleted, :video_page ]
  validates_numericality_of :vimeo_number, greater_than_or_equal_to: 0
  validates_numericality_of :position, greater_than_or_equal_to: 0

  # Model Relationships
  belongs_to :user

  # Model Methods

  def name
    self.photo_identifier
  end

  def video_page_string
    item = PAGES.select{|name, value| value == self.video_page}.first
    item ? item[0] : ""
  end
end
