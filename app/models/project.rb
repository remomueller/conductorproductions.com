class Project < ActiveRecord::Base

  # Uploaders
  mount_uploader :agency_logo, ImageUploader
  mount_uploader :client_logo, ImageUploader

  # Triggers
  after_create :create_default_categories

  # Constants
  DEFAULT_CATEGORIES = [
    {
      top_level: 'CREATIVE',
      categories: [
        ["Concepts", "concepts"],
        ["Treatment", "treatment"],
        ["Script", "script"],
        ["Boards", "boards"],
        ["References", "references"]
      ]
    },
    {
      top_level: 'TIMELINE',
      categories: [
        ["Production Calendar", "production-calendar"],
        ["Agency Overview", "agency-overview"]
      ]
    },
    {
      top_level: 'PRODUCTION',
      categories: [
        ["Production Book", "production-book"],
        ["Casting", "casting"],
        ["Locations", "locations"],
        ["Elements", "elements"]
      ]
    },
    {
      top_level: 'EDITORIAL',
      categories: [
        ["Music", "music"],
        ["Rough Cuts", "rough-cuts"],
        ["Final", "final"]
      ]
    },
  ]

  TOP_LEVELS = DEFAULT_CATEGORIES.collect{|hash| hash[:top_level]}

  # Concerns
  include Deletable

  has_secure_password

  # Named Scopes
  scope :with_editor, lambda { |*args| where('projects.user_id = ? or projects.id in (select project_users.project_id from project_users where project_users.user_id = ? and project_users.editor IN (?))', args.first, args.first, args[1] ).references(:project_users) }

  # Model Validation
  validates_presence_of :name, :user_id
  validates_uniqueness_of :slug, scope: [ :deleted ], allow_blank: true
  validates_format_of :slug, with: /\A[a-z][a-z0-9\-]*\Z/, allow_blank: true
  validates_uniqueness_of :username, :number, scope: [ :deleted ], allow_blank: true

  # Model Relationships
  belongs_to :user
  has_many :categories, -> { where(deleted: false).order(:top_level, :position) }
  has_many :documents, -> { where(deleted: false).order(:archived, document_uploaded_at: :desc) }
  has_many :embeds, -> { where(deleted: false).order(:archived, created_at: :desc) }
  has_many :locations, -> { where(deleted: false).order(:archived, created_at: :desc) }
  has_many :project_users
  has_many :users, -> { where( deleted: false ).order( 'last_name, first_name' ) }, through: :project_users
  has_many :editors, -> { where('project_users.editor = ? and users.deleted = ?', true, false) }, through: :project_users, source: :user
  has_many :viewers, -> { where('project_users.editor = ? and users.deleted = ?', false, false) }, through: :project_users, source: :user

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    self.where("projects.slug = ? or projects.id = ?", input.to_s, input.to_i).first
  end

  def grouped_categories_for_select
    groups = []
    TOP_LEVELS.each do |top_level|
      groups << [top_level, self.categories.where(top_level: top_level).pluck(:name, :id)]
    end
    groups
  end

  # Project Owners and Project Editors
  def editable_by?(current_user)
    @editable_by ||= begin
      current_user.all_projects.where(id: self.id).count == 1
    end
  end

  # Project Owners
  def deletable_by?(current_user)
    current_user.projects.where( id: self.id ).count == 1
  end


  private

    def create_default_categories
      DEFAULT_CATEGORIES.each do |hash|
        top_level = hash[:top_level]
        hash[:categories].each_with_index do |(name, slug), index|
          self.categories.create(top_level: top_level, name: name, slug: slug, position: index+1, user_id: self.user_id)
        end
      end
    end

end
