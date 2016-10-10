# frozen_string_literal: true

require 'test_helper'

# Tests to assure clients can browse project.
class ClientProjectControllerTest < ActionController::TestCase
  setup do
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
    @client = projects(:one)
    @client_two = projects(:two)
  end

  test 'should get client project root as client' do
    login_client(@client)
    get :root, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project root as owner' do
    login(@system_admin)
    get :root, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project root as editor' do
    login(@editor_project_one)
    get :root, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project root as viewer' do
    login(@viewer_project_one)
    get :root, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should not get client project root as logged out user' do
    get :root, params: { id: projects(:one) }
    assert_nil assigns(:project)
    assert_redirected_to client_login_path
  end

  test 'should get client project menu as client' do
    login_client(@client)
    get :menu, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project menu as owner' do
    login(@system_admin)
    get :menu, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project menu as editor' do
    login(@editor_project_one)
    get :menu, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project menu as viewer' do
    login(@viewer_project_one)
    get :menu, params: { id: projects(:one) }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should not get client project menu as logged out user' do
    get :menu, params: { id: projects(:one) }
    assert_nil assigns(:project)
    assert_redirected_to client_login_path
  end

  test 'should get client project concepts category as client' do
    login_client(@client)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'concepts' }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project concepts category as owner' do
    login(@system_admin)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'concepts' }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project concepts category as editor' do
    login(@editor_project_one)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'concepts' }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should get client project concepts category as viewer' do
    login(@viewer_project_one)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'concepts' }
    assert_not_nil assigns(:project)
    assert_response :success
  end

  test 'should not get client project concepts category as logged out user' do
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'concepts' }
    assert_nil assigns(:project)
    assert_redirected_to client_login_path
  end

  test 'should get client project treatment category as client' do
    login_client(@client)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'treatment' }
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'should get client project script category as client' do
    login_client(@client)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'script' }
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'should get client project boards category as client' do
    login_client(@client)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'boards' }
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'should get client project references category as client' do
    login_client(@client)
    get :category, params: { id: projects(:one), top_level: 'creative', category_id: 'references' }
    assert_response :success
    assert_not_nil assigns(:project)
  end

  test 'should get category and redirect to single gallery' do
    login_client(@client_two)
    get :category, params: { id: @client_two, top_level: 'production', category_id: categories(:locations_two) }
    assert_not_nil assigns(:project)
    assert_redirected_to client_project_gallery_path(@client_two, 'production', categories(:locations_two), galleries(:single_location))
  end

  test 'should get client project gallery as client' do
    login_client(@client)
    get :gallery_show, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery)
    assert_response :success
  end

  test 'should get client project gallery as owner' do
    login(@system_admin)
    get :gallery_show, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery)
    assert_response :success
  end

  test 'should get client project gallery as editor' do
    login(@editor_project_one)
    get :gallery_show, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery)
    assert_response :success
  end

  test 'should get client project gallery as viewer' do
    login(@viewer_project_one)
    get :gallery_show, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery)
    assert_response :success
  end

  test 'should not get client project gallery as logged out user' do
    get :gallery_show, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one) }
    assert_nil assigns(:project)
    assert_nil assigns(:gallery)
    assert_redirected_to client_login_path
  end

  test 'should get client project gallery photo as client' do
    login_client(@client)
    get :gallery_photo, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_response :success
  end

  test 'should get client project gallery photo as owner' do
    login(@system_admin)
    get :gallery_photo, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_response :success
  end

  test 'should get client project gallery photo as editor' do
    login(@editor_project_one)
    get :gallery_photo, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_response :success
  end

  test 'should get client project gallery photo as viewer' do
    login(@viewer_project_one)
    get :gallery_photo, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_response :success
  end

  test 'should not get client project gallery photo as logged out user' do
    get :gallery_photo, params: { id: projects(:one), top_level: 'production', category_id: 'locations', gallery_id: galleries(:one), gallery_photo_id: gallery_photos(:one) }
    assert_nil assigns(:project)
    assert_nil assigns(:gallery_photo)
    assert_redirected_to client_login_path
  end

  test 'should download client project gallery photo as client' do
    login_client(@client)
    get :download_gallery_photo, params: { id: projects(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should download client project gallery photo as owner' do
    login(@system_admin)
    get :download_gallery_photo, params: { id: projects(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should download client project gallery photo as editor' do
    login(@editor_project_one)
    get :download_gallery_photo, params: { id: projects(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should download client project gallery photo as viewer' do
    login(@viewer_project_one)
    get :download_gallery_photo, params: { id: projects(:one), gallery_photo_id: gallery_photos(:one) }
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:gallery_photo)
    assert_kind_of String, response.body
    assert_equal File.binread(File.join(CarrierWave::Uploader::Base.root, assigns(:gallery_photo).photo.url)), response.body
    assert_response :success
  end

  test 'should not download client project gallery photo as logged out user' do
    get :download_gallery_photo, params: { id: projects(:one), gallery_photo_id: gallery_photos(:one) }
    assert_nil assigns(:project)
    assert_nil assigns(:gallery_photo)
    assert_redirected_to client_login_path
  end
end
