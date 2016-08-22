# frozen_string_literal: true

require 'test_helper'

# Tests to assure that categories can be created and modified.
class CategoriesControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @category = categories(:concepts)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  def category_params
    {
      top_level: 'CREATIVE',
      name: 'New Category',
      slug: 'new-category',
      position: 1
    }
  end

  test 'should get index as owner' do
    login(@system_admin)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test 'should get index as editor' do
    login(@editor_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test 'should get index as viewer' do
    login(@viewer_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:categories)
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

  test 'should create category as owner' do
    login(@system_admin)
    assert_difference('Category.count') do
      post :create, params: { project_id: @project, category: category_params }
    end

    assert_not_nil assigns(:category)
    assert_equal 'New Category', assigns(:category).name
    assert_equal 'new-category', assigns(:category).slug
    assert_equal @system_admin.id, assigns(:category).user_id

    assert_redirected_to project_category_path(assigns(:project), assigns(:category))
  end

  test 'should create category as editor' do
    login(@editor_project_one)
    assert_difference('Category.count') do
      post :create, params: { project_id: @project, category: category_params }
    end
    assert_not_nil assigns(:category)
    assert_equal 'New Category', assigns(:category).name
    assert_equal 'new-category', assigns(:category).slug
    assert_equal @editor_project_one.id, assigns(:category).user_id
    assert_redirected_to project_category_path(assigns(:project), assigns(:category))
  end

  test 'should not create category as viewer' do
    login(@viewer_project_one)
    assert_difference('Category.count', 0) do
      post :create, params: { project_id: @project, category: category_params }
    end
    assert_nil assigns(:category)
    assert_redirected_to root_path
  end

  test 'should show category as owner' do
    login(@system_admin)
    get :show, params: { project_id: @project, id: @category }
    assert_response :success
  end

  test 'should show category as editor' do
    login(@editor_project_one)
    get :show, params: { project_id: @project, id: @category }
    assert_response :success
  end

  test 'should show category as viewer' do
    login(@viewer_project_one)
    get :show, params: { project_id: @project, id: @category }
    assert_response :success
  end

  test 'should get edit as owner' do
    login(@system_admin)
    get :edit, params: { project_id: @project, id: @category }
    assert_response :success
  end

  test 'should get edit as editor' do
    login(@editor_project_one)
    get :edit, params: { project_id: @project, id: @category }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer_project_one)
    get :edit, params: { project_id: @project, id: @category }
    assert_redirected_to root_path
  end

  test 'should update category as owner' do
    login(@system_admin)
    patch :update, params: { project_id: @project, id: @category, category: category_params.merge(name: 'Updated Category', slug: 'updated-category') }
    assert_redirected_to project_category_path(assigns(:project), assigns(:category))
  end

  test 'should update category as editor' do
    login(@editor_project_one)
    patch :update, params: { project_id: @project, id: @category, category: category_params.merge(name: 'Updated Category', slug: 'updated-category') }
    assert_redirected_to project_category_path(assigns(:project), assigns(:category))
  end

  test 'should not update category as viewer' do
    login(@viewer_project_one)
    patch :update, params: { project_id: @project, id: @category, category: category_params.merge(name: 'Updated Category', slug: 'updated-category') }
    assert_redirected_to root_path
  end

  test 'should destroy category as owner' do
    login(@system_admin)
    assert_difference('Category.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @category }
    end
    assert_redirected_to project_categories_path(assigns(:project))
  end

  test 'should destroy category as editor' do
    login(@editor_project_one)
    assert_difference('Category.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @category }
    end
    assert_redirected_to project_categories_path(assigns(:project))
  end

  test 'should not destroy category as viewer' do
    login(@viewer_project_one)
    assert_difference('Category.current.count', 0) do
      delete :destroy, params: { project_id: @project, id: @category }
    end
    assert_redirected_to root_path
  end
end
