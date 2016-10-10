# frozen_string_literal: true

# Contains the structure and elements for a project.
class Project < ApplicationRecord
  # Uploaders
  mount_uploader :agency_logo, ImageUploader
  mount_uploader :client_logo, ImageUploader

  # Triggers
  after_commit :create_default_categories, on: :create

  # Constants
  DEFAULT_CATEGORIES = [
    {
      top_level: 'CREATIVE',
      categories: [
        ['Concepts', 'concepts'],
        ['Treatment', 'treatment'],
        ['Script', 'script'],
        ['Boards', 'boards'],
        ['Animatic', 'animatic']
      ]
    },
    {
      top_level: 'TIMELINE',
      categories: [
        ['Production Calendar', 'production-calendar'],
        ['Agency Overview', 'agency-overview']
      ]
    },
    {
      top_level: 'TALENT',
      categories: []
    },
    {
      top_level: 'PRODUCTION',
      categories: [
        ['Production Book', 'production-book'],
        ['Casting', 'casting'],
        ['Talent', 'talent'],
        ['Locations', 'locations'],
        ['Style Swipe', 'style-swipe'],
        ['Set Design', 'set-design']
      ]
    },
    {
      top_level: 'EDITORIAL',
      categories: [
        ['Styleframes', 'styleframes'],
        ['Voiceover', 'voiceover'],
        ['Music', 'music']
      ]
    },
    {
      top_level: 'REFERENCES',
      categories: [
        ['Client Documents', 'client-documents'],
        ['Past Work', 'past-work'],
        ['Visual Style', 'visual-style']
      ]
    }
  ]

  TOP_LEVELS = DEFAULT_CATEGORIES.collect { |hash| hash[:top_level] }

  # Concerns
  include Deletable

  has_secure_password

  # Scopes
  scope :with_editor, -> (*args) { where('projects.user_id = ? or projects.id in (select project_users.project_id from project_users where project_users.user_id = ? and project_users.editor IN (?))', args.first, args.first, args[1]).references(:project_users) }

  # Model Validation
  validates :name, :user_id, presence: true
  validates :slug,
            uniqueness: true,
            allow_nil: true,
            format: { with: /\A[a-z][a-z0-9\-]*\Z/ }
  validates :username, :number, uniqueness: true, allow_nil: true
  validates :username, format: { with: /\A[a-zA-Z][a-zA-Z0-9]*\Z/ }, allow_nil: true

  # Model Relationships
  belongs_to :user
  has_many :categories, -> { current.order(:top_level, :position) }
  has_many :documents, -> { current.order(:archived, document_uploaded_at: :desc) }
  has_many :embeds, -> { current.order(:archived, created_at: :desc) }
  has_many :galleries, -> { current.order(:archived, created_at: :desc) }
  has_many :gallery_photos
  has_many :project_users
  has_many :users, -> { current.order(:last_name, :first_name) }, through: :project_users
  has_many :editors, -> { where('project_users.editor = ? and users.deleted = ?', true, false) }, through: :project_users, source: :user
  has_many :viewers, -> { where('project_users.editor = ? and users.deleted = ?', false, false) }, through: :project_users, source: :user

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    where('projects.slug = ? or projects.id = ?', input.to_s, input.to_i).first
  end

  def grouped_categories_for_select
    groups = []
    TOP_LEVELS.each do |top_level|
      groups << [top_level, categories.where(top_level: top_level).pluck(:name, :id)]
    end
    groups
  end

  def visible_top_level_categories(top_level)
    categories.where(top_level: top_level).select(&:show_menu?)
  end

  # Project Owners and Project Editors
  def editable_by?(current_user)
    @editable_by ||= begin
      current_user.all_projects.where(id: id).count == 1
    end
  end

  # Project Owners
  def deletable_by?(current_user)
    current_user.projects.where(id: id).count == 1
  end

  def destroy
    super
    update slug: nil, username: nil, number: nil
  end

  private

  def create_default_categories
    DEFAULT_CATEGORIES.each do |hash|
      top_level = hash[:top_level]
      hash[:categories].each_with_index do |(name, slug), index|
        categories.create(
          top_level: top_level,
          name: name,
          slug: slug,
          position: index + 1,
          user_id: user_id
        )
      end
    end
  end
end
