# frozen_string_literal: true

require 'test_helper'

# Tests to assure that galleries can have photos attached.
class GalleryPhotosControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @gallery = galleries(:one)
    @gallery_photo = gallery_photos(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  # test 'should get index' do
  #   get :index
  #   assert_response :success
  #   assert_not_nil assigns(:gallery_photos)
  # end

  # test 'should get new' do
  #   get :new
  #   assert_response :success
  # end

  # test 'should create gallery_photo' do
  #   assert_difference('GalleryPhoto.count') do
  #     post :create, params: { gallery_photo: { gallery_id: @gallery_photo.gallery_id, photo: @gallery_photo.photo, project_id: @gallery_photo.project_id, user_id: @gallery_photo.user_id } }
  #   end
  #   assert_redirected_to gallery_photo_path(assigns(:gallery_photo))
  # end

  test 'should download gallery photo as owner' do
    login(@system_admin)
    get :download, params: { project_id: @project, gallery_id: @gallery, id: @gallery_photo }
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should download gallery photo as editor' do
    login(@editor_project_one)
    get :download, params: { project_id: @project, gallery_id: @gallery, id: @gallery_photo }
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should download gallery photo as viewer' do
    login(@viewer_project_one)
    get :download, params: { project_id: @project, gallery_id: @gallery, id: @gallery_photo }
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should show gallery photo as owner' do
    login(@system_admin)
    get :show, params: { project_id: @project, gallery_id: @gallery, id: @gallery_photo }
    assert_response :success
  end

  test 'should show gallery photo as editor' do
    login(@editor_project_one)
    get :show, params: { project_id: @project, gallery_id: @gallery, id: @gallery_photo }
    assert_response :success
  end

  test 'should show gallery photo as viewer' do
    login(@viewer_project_one)
    get :show, params: { project_id: @project, gallery_id: @gallery, id: @gallery_photo }
    assert_response :success
  end

  # test 'should get edit' do
  #   get :edit, params: { id: @gallery_photo }
  #   assert_response :success
  # end

  # test 'should update gallery_photo' do
  #   patch :update, params: { id: @gallery_photo, gallery_photo: { gallery_id: @gallery_photo.gallery_id, photo: @gallery_photo.photo, project_id: @gallery_photo.project_id, user_id: @gallery_photo.user_id } }
  #   assert_redirected_to gallery_photo_path(assigns(:gallery_photo))
  # end

  test 'should destroy gallery photo as owner' do
    login(@system_admin)
    assert_difference('GalleryPhoto.count', -1) do
      delete :destroy, params: { project_id: @project, gallery_id: @gallery, id: gallery_photos(:three) }
    end
    assert_redirected_to [assigns(:project), assigns(:gallery)]
  end

  test 'should destroy gallery photo as editor' do
    login(@editor_project_one)
    assert_difference('GalleryPhoto.count', -1) do
      delete :destroy, params: { project_id: @project, gallery_id: @gallery, id: gallery_photos(:three) }
    end
    assert_redirected_to [assigns(:project), assigns(:gallery)]
  end

  test 'should not destroy gallery photo as viewer' do
    login(@viewer_project_one)
    assert_difference('GalleryPhoto.count', 0) do
      delete :destroy, params: { project_id: @project, gallery_id: @gallery, id: gallery_photos(:three) }
    end
    assert_redirected_to root_path
  end
end
