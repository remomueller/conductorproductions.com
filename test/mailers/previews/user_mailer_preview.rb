# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def contact
    UserMailer.contact("FirstName LastName", "example@test.com", "This is my message\nOn two lines!")
  end

  def user_added_to_project
    project_user = ProjectUser.where.not( invite_email: nil ).first
    UserMailer.user_added_to_project(project_user)
  end

  def invite_user_to_project
    project_user = ProjectUser.where.not( invite_email: nil ).first
    UserMailer.invite_user_to_project(project_user)
  end

end
