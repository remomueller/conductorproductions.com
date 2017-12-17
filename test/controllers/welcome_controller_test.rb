# frozen_string_literal: true

require "test_helper"

# Tests to assure that public pages are viewable.
class WelcomeControllerTest < ActionController::TestCase
  test "should get index" do
    skip
    get :index
    assert_response :success
  end

  test "should get index as client" do
    skip
    login_client(@client)
    get :index
    assert_response :success
  end

  test "should get index as system admin" do
    skip
    login(@system_admin)
    get :index
    assert_response :success
  end

  test "should get index as collaborator" do
    skip
    login(@collaborator)
    get :index
    assert_response :success
  end

  # Older versions

  # test "should get about" do
  #   get :about
  #   assert_response :success
  # end

  # test "should get clients" do
  #   get :clients
  #   assert_response :success
  # end

  # test "should get news" do
  #   get :news
  #   assert_response :success
  # end

  # test "should get index_v1" do
  #   get :index_v1
  #   assert_response :success
  # end

  # test "should get index_v2" do
  #   get :index_v2
  #   assert_response :success
  # end
end
