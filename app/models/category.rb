class Category < ActiveRecord::Base

  # Concerns
  include Deletable

  # Model Validation
  validates_presence_of :top_level, :name, :slug, :position, :project_id, :user_id
  validates_uniqueness_of :slug, scope: [ :project_id, :deleted ]
  validates_format_of :slug, with: /\A[a-z][a-z0-9\-]*\Z/

  # Model Relationships
  belongs_to :project
  belongs_to :user

  # Category Methods
  has_many :documents, -> { where(deleted: false).order(:archived) }
  has_many :embeds, -> { where(deleted: false).order(:archived) }
  has_many :locations, -> { where(deleted: false).order(:archived) }

  def to_param
    slug.blank? ? id : slug
  end

  def self.find_by_param(input)
    self.where("categories.slug = ? or categories.id = ?", input.to_s, input.to_i).first
  end

  def pdf_documents
    self.documents.where("documents.document LIKE '%.pdf'")
  end

  def show_menu?
    self.documents.count + self.embeds.count + self.locations.count > 0
  end

end
