# frozen_string_literal: true

# Provides methods to invite a new member to an existing project.
class ProjectUser < ApplicationRecord
  # Concerns
  include Forkable

  # Model Validation
  validates :creator_id, :project_id, presence: true
  validates :invite_token, uniqueness: true, allow_nil: true

  # Model Relationships
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'
  belongs_to :project
  belongs_to :user

  def send_user_invited_email_in_background!
    set_invite_token
    fork_process(:send_user_invited_email!)
  end

  def send_user_added_email_in_background!
    fork_process(:send_user_added_email!)
  end

  private

  def set_invite_token
    return unless invite_token.blank?
    update invite_token: SecureRandom.hex(12)
  rescue ActiveRecord::RecordNotUnique, ActiveRecord::RecordInvalid
    retry
  end

  def send_user_invited_email!
    return unless EMAILS_ENABLED
    UserMailer.user_invited_to_project(self).deliver_now if invite_token.present?
  end

  def send_user_added_email!
    return unless EMAILS_ENABLED
    UserMailer.user_added_to_project(self).deliver_now if invite_token.blank? && user
  end
end
