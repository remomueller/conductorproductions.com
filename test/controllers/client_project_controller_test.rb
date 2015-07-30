require 'test_helper'

class ClientProjectControllerTest < ActionController::TestCase
  setup do
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
    @client = projects(:one)
  end

  test "should get client project root as client" do
    login_client(@client)
    get :root, id: projects(:one)
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test "should not get client project root as logged out user" do
    get :root, id: projects(:one)
    assert_nil assigns(:project)
    assert_redirected_to client_login_path
  end

  test "should get client project menu as client" do
    login_client(@client)
    get :menu, id: projects(:one)
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project concepts category as client" do
    login_client(@client)
    get :category, id: projects(:one), top_level: 'creative', category_id: 'concepts'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project treatment category as client" do
    login_client(@client)
    get :category, id: projects(:one), top_level: 'creative', category_id: 'treatment'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project script category as client" do
    login_client(@client)
    get :category, id: projects(:one), top_level: 'creative', category_id: 'script'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project boards category as client" do
    login_client(@client)
    get :category, id: projects(:one), top_level: 'creative', category_id: 'boards'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project references category as client" do
    login_client(@client)
    get :category, id: projects(:one), top_level: 'creative', category_id: 'references'
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test "should get client project location as client" do
    login_client(@client)
    get :location_show, id: projects(:one), top_level: 'production', category_id: 'locations', location_id: locations(:one)
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:location)
    assert_response :success
  end

  test "should get client project location photo as client" do
    login_client(@client)
    get :location_photo, id: projects(:one), top_level: 'production', category_id: 'locations', location_id: locations(:one), location_photo_id: location_photos(:one)
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:location_photo)
    assert_response :success
  end

  test "should download client project location photo as client" do
    login_client(@client)
    get :download_location_photo, id: projects(:one), location_photo_id: location_photos(:one)
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:location_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:location_photo).photo.url)), response.body
    assert_response :success
  end
end
