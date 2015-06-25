require 'test_helper'

class UserMailerTest < ActionMailer::TestCase

  test "contact email" do
    # Send the email, then test that it got queued
    email = UserMailer.contact("Name", "test@example.com", "Body of Message").deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    # Test the body of the sent email contains what we expect it to
    assert_equal ["reels@conductorproductions.com"], email.to
    assert_equal "Name - Website Message", email.subject
    assert_match(/Body of Message/, email.encoded)
  end

end
