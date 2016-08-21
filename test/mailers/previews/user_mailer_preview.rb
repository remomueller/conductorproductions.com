# frozen_string_literal: true

# Allows emails to be viewed at /rails/mailers
class UserMailerPreview < ActionMailer::Preview
  def contact
    UserMailer.contact('FirstName LastName', 'example@test.com', "This is my message\nOn two lines!")
  end

  def user_invited_to_project
    project_user = ProjectUser.where.not(invite_email: nil).first
    UserMailer.user_invited_to_project(project_user)
  end

  def user_added_to_project
    project_user = ProjectUser.where.not(user_id: nil).first
    UserMailer.user_added_to_project(project_user)
  end
end
