# frozen_string_literal: true

require "test_helper"

SimpleCov.command_name "test:integration"

# Tests to assure that user navigation is working as intended.
class NavigationTest < ActionDispatch::IntegrationTest
  test "regular users should be able to login" do
    get dashboard_url
    assert_redirected_to new_user_session_path
    login(users(:regular))
    assert_equal dashboard_path, path
  end

  test "project viewers should be able to login" do
    project = projects(:one)
    project.update password: project.password_plain, password_confirmation: project.password_plain
    post new_user_session_url, params: { user: { email: project.username, password: project.password_plain } }
    follow_redirect!
    assert_equal "/project-one/menu", path
  end

  test "project viewers should stay on login page with incorrect password" do
    project = projects(:one)
    project.update password: project.password_plain, password_confirmation: project.password_plain
    post new_user_session_url, params: { user: { email: project.username, password: "wrong" } }
    follow_redirect!
    assert_equal new_user_session_path, path
  end

  test "deleted users should be not be allowed to login" do
    get dashboard_url
    assert_redirected_to new_user_session_path
    login(users(:deleted))
    assert_equal new_user_session_path, path
    assert_equal I18n.t("devise.failure.inactive"), flash[:alert]
  end

  test "root navigation redirected to login page" do
    get dashboard_url
    assert_redirected_to new_user_session_path
    assert_equal I18n.t("devise.failure.unauthenticated"), flash[:alert]
  end

  test "friendly url forwarding after client login" do
    get client_project_category_url(id: "project-one", top_level: "production", category_id: "locations")
    assert_redirected_to client_login_path
    sign_in_as_client(projects(:one))
    assert_equal "/project-one/production/locations", path
  end

  test "friendly url forwarding if already logged in client logs in to link for different project" do
    sign_in_as_client(projects(:two))
    assert_equal "/project-two/menu", path
    get client_project_category_url(id: "project-one", top_level: "production", category_id: "locations")
    assert_redirected_to client_login_path
    sign_in_as_client(projects(:one))
    assert_equal "/project-one/production/locations", path
  end

  test "should ignore friendly url forwarding if client logs in to different project than the friendly forwaring url" do
    get client_project_category_url(id: "project-one", top_level: "production", category_id: "locations")
    assert_redirected_to client_login_path
    sign_in_as_client(projects(:two))
    assert_equal "/project-two/menu", path
  end
end
