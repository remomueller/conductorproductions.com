# frozen_string_literal: true

require 'test_helper'

# Tests to assure that locations can have photos attached.
class LocationPhotosControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @location = locations(:one)
    @location_photo = location_photos(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  # test "should get index" do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:location_photos)
  # end

  # test "should get new" do
  #   get :new
  #   assert_response :success
  # end

  # test "should create location_photo" do
  #   assert_difference('LocationPhoto.count') do
  #     post :create, location_photo: { location_id: @location_photo.location_id, photo: @location_photo.photo, project_id: @location_photo.project_id, user_id: @location_photo.user_id }
  #   end

  #   assert_redirected_to location_photo_path(assigns(:location_photo))
  # end

  test "should download location photo as owner" do
    login(@system_admin)
    get :download, project_id: @project, location_id: @location, id: @location_photo
    assert_not_nil assigns(:location_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:location_photo).photo.url)), response.body
    assert_response :success
  end

  test "should download location photo as editor" do
    login(@editor_project_one)
    get :download, project_id: @project, location_id: @location, id: @location_photo
    assert_not_nil assigns(:location_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:location_photo).photo.url)), response.body
    assert_response :success
  end

  test "should download location photo as viewer" do
    login(@viewer_project_one)
    get :download, project_id: @project, location_id: @location, id: @location_photo
    assert_not_nil assigns(:location_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:location_photo).photo.url)), response.body
    assert_response :success
  end

  test "should show location photo as owner" do
    login(@system_admin)
    get :show, project_id: @project, location_id: @location, id: @location_photo
    assert_response :success
  end

  test "should show location photo as editor" do
    login(@editor_project_one)
    get :show, project_id: @project, location_id: @location, id: @location_photo
    assert_response :success
  end

  test "should show location photo as viewer" do
    login(@viewer_project_one)
    get :show, project_id: @project, location_id: @location, id: @location_photo
    assert_response :success
  end

  # test "should get edit" do
  #   get :edit, id: @location_photo
  #   assert_response :success
  # end

  # test "should update location_photo" do
  #   patch :update, id: @location_photo, location_photo: { location_id: @location_photo.location_id, photo: @location_photo.photo, project_id: @location_photo.project_id, user_id: @location_photo.user_id }
  #   assert_redirected_to location_photo_path(assigns(:location_photo))
  # end

  test "should destroy location photo as owner" do
    login(@system_admin)
    assert_difference('LocationPhoto.count', -1) do
      delete :destroy, project_id: @project, location_id: @location, id: location_photos(:three)
    end

    assert_redirected_to [assigns(:project), assigns(:location)]
  end

  test "should destroy location photo as editor" do
    login(@editor_project_one)
    assert_difference('LocationPhoto.count', -1) do
      delete :destroy, project_id: @project, location_id: @location, id: location_photos(:three)
    end

    assert_redirected_to [assigns(:project), assigns(:location)]
  end

  test "should not destroy location photo as viewer" do
    login(@viewer_project_one)
    assert_difference('LocationPhoto.count', 0) do
      delete :destroy, project_id: @project, location_id: @location, id: location_photos(:three)
    end

    assert_redirected_to root_path
  end
end
