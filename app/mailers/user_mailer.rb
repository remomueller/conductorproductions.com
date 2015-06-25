class UserMailer < ApplicationMailer

  def contact(name, email, message)
    subject = "#{name} - Website Message"
    @email_to = 'reels@conductorproductions.com'
    @message = message
    mail(to: @email_to, subject: subject, reply_to: email)
  end

end
