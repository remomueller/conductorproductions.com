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

  test "user added to project email" do
    project_user = project_users(:accepted_viewer_invite)

    email = UserMailer.user_added_to_project(project_user).deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [project_user.user.email], email.to
    assert_equal "#{project_user.creator.name} Allows You to View Project #{project_user.project.name}", email.subject
    assert_match(/#{project_user.creator.name} added you to Project #{project_user.project.name}/, email.encoded)
  end

  test "user invited to project email" do
    project_user = project_users(:pending_editor_invite)

    email = UserMailer.invite_user_to_project(project_user).deliver_now
    assert !ActionMailer::Base.deliveries.empty?

    assert_equal [project_user.invite_email], email.to
    assert_equal "#{project_user.creator.name} Invites You to Edit Project #{project_user.project.name}", email.subject
    assert_match(/#{project_user.creator.name} invited you to Project #{project_user.project.name}/, email.encoded)
  end

end
