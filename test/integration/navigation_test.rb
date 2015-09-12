require 'test_helper'

SimpleCov.command_name "test:integration"

class NavigationTest < ActionDispatch::IntegrationTest
  test "regular users should be able to login" do
    get "/dashboard"
    assert_redirected_to new_user_session_path

    sign_in_as(users(:regular), "123456")
    assert_equal '/dashboard', path
    assert_equal I18n.t('devise.sessions.signed_in'), flash[:notice]
  end

  test "deleted users should be not be allowed to login" do
    get "/dashboard"
    assert_redirected_to new_user_session_path

    sign_in_as(users(:deleted), "123456")
    assert_equal new_user_session_path, path
    assert_equal I18n.t('devise.failure.inactive'), flash[:alert]
  end

  test "root navigation redirected to login page" do
    get "/dashboard"
    assert_redirected_to new_user_session_path
    assert_equal I18n.t('devise.failure.unauthenticated'), flash[:alert]
  end
end
