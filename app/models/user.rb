class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Concerns
  include Deletable

  # Named Scopes
  scope :with_project, lambda { |*args| where("users.id in (select projects.user_id from projects where projects.id IN (?) and projects.deleted = ?) or users.id in (select project_users.user_id from project_users where project_users.project_id IN (?) and project_users.editor IN (?))", args.first, false, args.first, args[1] ) }

  # Model Validation
  validates_presence_of :first_name, :last_name

  # Model Relationships
  has_many :projects, -> { where deleted: false }
  has_many :categories, -> { where deleted: false }
  has_many :documents, -> { where deleted: false }
  has_many :embeds, -> { where deleted: false }

  # User Methods

  def name
    "#{first_name} #{last_name}"
  end

  def all_projects
    Project.current.with_editor(self.id, true)
  end

  def all_viewable_projects
    Project.current.with_editor(self.id, [true, false])
  end

  def associated_users
    User.current.with_project(self.all_projects.pluck(:id), [true, false])
  end

end
