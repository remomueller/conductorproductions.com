# frozen_string_literal: true

require 'test_helper'

# Tests to assure that locations can be created and modified.
class LocationsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @location = locations(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  def location_params
    {
      category_id: @location.category_id,
      name: 'New Location',
      slug: 'new-location',
      address: @location.address,
      archived: @location.archived
    }
  end

  test 'should get index as owner' do
    login(@system_admin)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test 'should get index as editor' do
    login(@editor_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:locations)
  end

  test 'should get index as viewer' do
    login(@viewer_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:locations)
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

  test 'should create location as owner' do
    login(@system_admin)
    assert_difference('Location.count') do
      post :create, params: { project_id: @project, location: location_params }
    end
    assert_redirected_to project_location_path(assigns(:project), assigns(:location))
  end

  test 'should create location as editor' do
    login(@editor_project_one)
    assert_difference('Location.count') do
      post :create, params: { project_id: @project, location: location_params }
    end
    assert_redirected_to project_location_path(assigns(:project), assigns(:location))
  end

  test 'should not create location as viewer' do
    login(@viewer_project_one)
    assert_difference('Location.count', 0) do
      post :create, params: { project_id: @project, location: location_params }
    end
    assert_redirected_to root_path
  end

  test 'should show location as owner' do
    login(@system_admin)
    get :show, params: { project_id: @project, id: @location }
    assert_response :success
  end

  test 'should show location as editor' do
    login(@editor_project_one)
    get :show, params: { project_id: @project, id: @location }
    assert_response :success
  end

  test 'should show location as viewer' do
    login(@viewer_project_one)
    get :show, params: { project_id: @project, id: @location }
    assert_response :success
  end

  test 'should get edit as owner' do
    login(@system_admin)
    get :edit, params: { project_id: @project, id: @location }
    assert_response :success
  end

  test 'should get edit as editor' do
    login(@editor_project_one)
    get :edit, params: { project_id: @project, id: @location }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer_project_one)
    get :edit, params: { project_id: @project, id: @location }
    assert_redirected_to root_path
  end

  test 'should update location as owner' do
    login(@system_admin)
    patch :update, params: { project_id: @project, id: @location, location: location_params.merge(name: 'Updated Location', slug: 'updated-location') }
    assert_redirected_to project_location_path(assigns(:project), assigns(:location))
  end

  test 'should update location as editor' do
    login(@editor_project_one)
    patch :update, params: { project_id: @project, id: @location, location: location_params.merge(name: 'Updated Location', slug: 'updated-location') }
    assert_redirected_to project_location_path(assigns(:project), assigns(:location))
  end

  test 'should not update location as viewer' do
    login(@viewer_project_one)
    patch :update, params: { project_id: @project, id: @location, location: location_params.merge(name: 'Updated Location', slug: 'updated-location') }
    assert_redirected_to root_path
  end

  test 'should destroy location as owner' do
    login(@system_admin)
    assert_difference('Location.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @location }
    end
    assert_redirected_to project_locations_path(assigns(:project))
  end

  test 'should destroy location as editor' do
    login(@editor_project_one)
    assert_difference('Location.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @location }
    end
    assert_redirected_to project_locations_path(assigns(:project))
  end

  test 'should not destroy location as viewer' do
    login(@viewer_project_one)
    assert_difference('Location.current.count', 0) do
      delete :destroy, params: { project_id: @project, id: @location }
    end
    assert_redirected_to root_path
  end
end
