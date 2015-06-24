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

  test "should get client project concepts category" do
    get :category, id: projects(:one), top_level: 'creative', category_id: 'concepts'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project treatment category" do
    get :category, id: projects(:one), top_level: 'creative', category_id: 'treatment'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project script category" do
    get :category, id: projects(:one), top_level: 'creative', category_id: 'script'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project boards category" do
    get :category, id: projects(:one), top_level: 'creative', category_id: 'boards'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project references category" do
    get :category, id: projects(:one), top_level: 'creative', category_id: 'references'
    assert_response :success
    assert_not_nil assigns(:project)
  end
end
