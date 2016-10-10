# frozen_string_literal: true

require 'test_helper'

# Tests to assure that galleries can be created and modified.
class GalleriesControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @gallery = galleries(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  def gallery_params
    {
      category_id: @gallery.category_id,
      name: 'New Gallery',
      slug: 'new-gallery',
      address: @gallery.address,
      archived: @gallery.archived
    }
  end

  test 'should get index as owner' do
    login(@system_admin)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:galleries)
  end

  test 'should get index as editor' do
    login(@editor_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:galleries)
  end

  test 'should get index as viewer' do
    login(@viewer_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:galleries)
  end

  test 'should get new as owner' do
    login(@system_admin)
    get :new, params: { project_id: @project }
    assert_response :success
  end

  test 'should get new as editor' do
    login(@editor_project_one)
    get :new, params: { project_id: @project }
    assert_response :success
  end

  test 'should not get new as viewer' do
    login(@viewer_project_one)
    get :new, params: { project_id: @project }
    assert_redirected_to root_path
  end

  test 'should create gallery as owner' do
    login(@system_admin)
    assert_difference('Gallery.count') do
      post :create, params: { project_id: @project, gallery: gallery_params }
    end
    assert_redirected_to project_gallery_path(assigns(:project), assigns(:gallery))
  end

  test 'should create gallery as editor' do
    login(@editor_project_one)
    assert_difference('Gallery.count') do
      post :create, params: { project_id: @project, gallery: gallery_params }
    end
    assert_redirected_to project_gallery_path(assigns(:project), assigns(:gallery))
  end

  test 'should not create gallery as viewer' do
    login(@viewer_project_one)
    assert_difference('Gallery.count', 0) do
      post :create, params: { project_id: @project, gallery: gallery_params }
    end
    assert_redirected_to root_path
  end

  test 'should show gallery as owner' do
    login(@system_admin)
    get :show, params: { project_id: @project, id: @gallery }
    assert_response :success
  end

  test 'should show gallery as editor' do
    login(@editor_project_one)
    get :show, params: { project_id: @project, id: @gallery }
    assert_response :success
  end

  test 'should show gallery as viewer' do
    login(@viewer_project_one)
    get :show, params: { project_id: @project, id: @gallery }
    assert_response :success
  end

  test 'should get edit as owner' do
    login(@system_admin)
    get :edit, params: { project_id: @project, id: @gallery }
    assert_response :success
  end

  test 'should get edit as editor' do
    login(@editor_project_one)
    get :edit, params: { project_id: @project, id: @gallery }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer_project_one)
    get :edit, params: { project_id: @project, id: @gallery }
    assert_redirected_to root_path
  end

  test 'should update gallery as owner' do
    login(@system_admin)
    patch :update, params: { project_id: @project, id: @gallery, gallery: gallery_params.merge(name: 'Updated Gallery', slug: 'updated-gallery') }
    assert_redirected_to project_gallery_path(assigns(:project), assigns(:gallery))
  end

  test 'should update gallery as editor' do
    login(@editor_project_one)
    patch :update, params: { project_id: @project, id: @gallery, gallery: gallery_params.merge(name: 'Updated Gallery', slug: 'updated-gallery') }
    assert_redirected_to project_gallery_path(assigns(:project), assigns(:gallery))
  end

  test 'should not update gallery as viewer' do
    login(@viewer_project_one)
    patch :update, params: { project_id: @project, id: @gallery, gallery: gallery_params.merge(name: 'Updated Gallery', slug: 'updated-gallery') }
    assert_redirected_to root_path
  end

  test 'should destroy gallery as owner' do
    login(@system_admin)
    assert_difference('Gallery.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @gallery }
    end
    assert_redirected_to project_galleries_path(assigns(:project))
  end

  test 'should destroy gallery as editor' do
    login(@editor_project_one)
    assert_difference('Gallery.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @gallery }
    end
    assert_redirected_to project_galleries_path(assigns(:project))
  end

  test 'should not destroy gallery as viewer' do
    login(@viewer_project_one)
    assert_difference('Gallery.current.count', 0) do
      delete :destroy, params: { project_id: @project, id: @gallery }
    end
    assert_redirected_to root_path
  end
end
