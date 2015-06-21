class Project < ActiveRecord::Base

  # Triggers
  after_create :create_default_categories

  # Constants
  DEFAULT_CATEGORIES = [
    ["Concepts", "concepts"],
    ["Treatment", "treatment"],
    ["Script","script"],
    ["Boards","boards"],
    ["References","references"]
  ]

  # Concerns
  include Deletable

  has_secure_password

  # Model Validation
  validates_presence_of :name, :user_id
  validates_uniqueness_of :slug, scope: [ :deleted ], allow_blank: true
  validates_format_of :slug, with: /\A[a-z][a-z0-9\-]*\Z/, allow_blank: true
  validates_uniqueness_of :username, :number, scope: [ :deleted ], allow_blank: true

  # Model Relationships
  belongs_to :user
  has_many :categories, -> { where(deleted: false).order(:position) }

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    self.where("projects.slug = ? or projects.id = ?", input.to_s, input.to_i).first
  end

  private

    def create_default_categories
      DEFAULT_CATEGORIES.each_with_index do |(name, slug), index|
        self.categories.create(name: name, slug: slug, position: index+1, user_id: self.user_id)
      end
    end

end
