# frozen_string_literal: true

# Sends out application emails to users.
class UserMailer < ApplicationMailer
  def contact(name, email, message)
    subject = "#{name} - Website Message"
    @email_to = ENV['contact_email']
    @message = message
    mail(to: @email_to, subject: subject, reply_to: email)
  end

  def user_added_to_project(project_user)
    @project_user = project_user
    @email_to = project_user.user.email
    mail(to: project_user.user.email,
         subject: "#{project_user.creator.name} Allows You to #{project_user.editor? ? 'Edit' : 'View'} #{project_user.project.name}",
         reply_to: project_user.creator.email)
  end

  def user_invited_to_project(project_user)
    @project_user = project_user
    @email_to = project_user.invite_email
    mail(to: project_user.invite_email,
         subject: "#{project_user.creator.name} Invites You to #{project_user.editor? ? 'Edit' : 'View'} #{project_user.project.name}",
         reply_to: project_user.creator.email)
  end
end
