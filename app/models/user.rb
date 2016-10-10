# frozen_string_literal: true

# Provides methods for users.
class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, and :omniauthable
  devise :database_authenticatable, :registerable, :timeoutable,
         :recoverable, :rememberable, :trackable, :validatable

  # Concerns
  include Deletable

  # Scopes
  scope :with_project, -> (*args) { where("users.id in (select projects.user_id from projects where projects.id IN (?) and projects.deleted = ?) or users.id in (select project_users.user_id from project_users where project_users.project_id IN (?) and project_users.editor IN (?))", args.first, false, args.first, args[1] ) }

  # Model Validation
  validates :first_name, :last_name, presence: true

  # Model Relationships
  has_many :videos, -> { current }
  has_many :projects, -> { current }
  has_many :categories, -> { current }
  has_many :documents, -> { current }
  has_many :embeds, -> { current }
  has_many :galleries, -> { current }

  # User Methods

  def name
    "#{first_name} #{last_name}"
  end

  def all_projects
    Project.current.with_editor(id, true)
  end

  def all_viewable_projects
    Project.current.with_editor(id, [true, false])
  end

  def associated_users
    User.current.with_project(all_projects.pluck(:id), [true, false])
  end

  # Overriding Devise built-in active_for_authentication? method
  def active_for_authentication?
    super && !deleted?
  end
end
