# frozen_string_literal: true

require 'test_helper'

# Tests to assure that emails are generated and sent.
class UserMailerTest < ActionMailer::TestCase
  test 'contact email' do
    mail = UserMailer.contact('Name', 'test@example.com', 'Body of Message')
    assert_equal [ENV['contact_email']], mail.to
    assert_equal 'Name - Website Message', mail.subject
    assert_match(/Body of Message/, mail.body.encoded)
  end

  test 'user added to project email' do
    project_user = project_users(:accepted_viewer_invite)
    mail = UserMailer.user_added_to_project(project_user)
    assert_equal [project_user.user.email], mail.to
    assert_equal "#{project_user.creator.name} Allows You to View #{project_user.project.name}", mail.subject
    assert_match(/#{project_user.creator.name} added you to #{project_user.project.name}/, mail.body.encoded)
  end

  test 'user invited to project email' do
    project_user = project_users(:pending_editor_invite)
    mail = UserMailer.user_invited_to_project(project_user)
    assert_equal [project_user.invite_email], mail.to
    assert_equal "#{project_user.creator.name} Invites You to Edit #{project_user.project.name}", mail.subject
    assert_match(/#{project_user.creator.name} invited you to #{project_user.project.name}/, mail.body.encoded)
  end
end
