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

  test "should get client project location" do
    get :location, id: projects(:one), top_level: 'production', category_id: 'locations', location_id: locations(:one)
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:location)
    assert_response :success
  end

  test "should get client project location photo" do
    get :location_photo, id: projects(:one), top_level: 'production', category_id: 'locations', location_id: locations(:one), location_photo_id: location_photos(:one)
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:location_photo)
    assert_response :success
  end

  test "should download client project location photo" do
    get :download_location_photo, id: projects(:one), location_photo_id: location_photos(:one)
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:location_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:location_photo).photo.url)), response.body
    assert_response :success
  end
end
