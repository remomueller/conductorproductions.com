class Location < ActiveRecord::Base

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :project_id, :user_id, :category_id, :name
  validates_uniqueness_of :slug, scope: [ :project_id, :deleted ]
  validates_format_of :slug, with: /\A[a-z][a-z0-9\-]*\Z/

  # Model Relationships
  belongs_to :project
  belongs_to :user
  belongs_to :category
  has_many :location_photos

  # Location Methods

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    self.where("locations.slug = ? or locations.id = ?", input.to_s, input.to_i).first
  end

end
