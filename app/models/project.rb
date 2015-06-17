class Project < ActiveRecord::Base

  # Concerns
  include Deletable

  has_secure_password

  # Model Validation
  validates_presence_of :name, :user_id
  validates_uniqueness_of :slug, scope: [ :deleted ], allow_blank: true
  validates_format_of :slug, with: /\A[a-z][a-z0-9\-]*\Z/, allow_blank: true
  validates_uniqueness_of :username, :number, allow_blank: true

  # Model Relationships
  belongs_to :user

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    self.where("projects.slug = ? or projects.id = ?", input.to_s, input.to_i).first
  end

end
