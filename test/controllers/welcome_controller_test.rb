require 'test_helper'

class WelcomeControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get work" do
    get :work
    assert_response :success
  end

  test "should get drtv" do
    get :drtv
    assert_response :success
  end

  test "should get contact" do
    get :contact
    assert_response :success
  end

  test "should get news" do
    get :news
    assert_response :success
  end

  test "should get clients" do
    get :clients
    assert_response :success
  end

  test "should get about" do
    get :about
    assert_response :success
  end

  # Older versions

  test "should get index_v1" do
    get :index_v1
    assert_response :success
  end

  test "should get index_v2" do
    get :index_v1
    assert_response :success
  end

end
