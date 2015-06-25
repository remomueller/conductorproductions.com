# Preview all emails at http://localhost:3000/rails/mailers/user_mailer
class UserMailerPreview < ActionMailer::Preview

  def contact
    UserMailer.contact("FirstName LastName", "example@test.com", "This is my message\nOn two lines!")
  end

end
