require 'test_helper'

class ClientProjectControllerTest < ActionController::TestCase
  setup do
    login_client(projects(:one))
  end

  test "should get client project root" do
    get :root, id: projects(:one)
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project menu" do
    get :menu, id: projects(:one)
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project script" do
    get :script, id: projects(:one)
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project casting" do
    get :casting, id: projects(:one)
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project timeline" do
    get :timeline, id: projects(:one)
    assert_response :success
    assert_not_nil assigns(:project)
  end
end
