class Video < ActiveRecord::Base

  # Uploaders
  mount_uploader :photo, VideoImageUploader

  # Constants
  PAGES = [['WORK', 'work'],['DRTV', 'drtv']]

  # Concerns
  include Deletable

  # Named Scopes

  # Model Validation
  validates_presence_of :page, :vimeo_number, :photo, :position, :user_id
  validates_inclusion_of :page, in: %w( work drtv )
  validates_uniqueness_of :vimeo_number, scope: [ :deleted, :page ]
  validates_numericality_of :vimeo_number, greater_than_or_equal_to: 0
  validates_numericality_of :position, greater_than_or_equal_to: 0

  # Model Relationships
  belongs_to :user

  # Model Methods

  def page_string
    item = PAGES.select{|name, value| value == self.page}.first
    item ? item[0] : ""
  end
end
