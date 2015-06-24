require 'test_helper'

class CategoriesControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @category = categories(:concepts)
    login(users(:system_admin))
  end

  test "should get index" do
    get :index, project_id: @project
    assert_response :success
    assert_not_nil assigns(:categories)
  end

  test "should get new" do
    get :new, project_id: @project
    assert_response :success
  end

  test "should create category" do
    assert_difference('Category.count') do
      post :create, project_id: @project, category: { top_level: 'CREATIVE', name: 'New Category', slug: 'new-category', position: 1 }
    end

    assert_not_nil assigns(:category)
    assert_equal 'New Category', assigns(:category).name
    assert_equal 'new-category', assigns(:category).slug
    assert_equal users(:system_admin).id, assigns(:category).user_id

    assert_redirected_to project_category_path(assigns(:project), assigns(:category))
  end

  test "should show category" do
    get :show, project_id: @project, id: @category
    assert_response :success
  end

  test "should get edit" do
    get :edit, project_id: @project, id: @category
    assert_response :success
  end

  test "should update category" do
    patch :update, project_id: @project, id: @category, category: { top_level: 'CREATIVE', name: 'Updated Category', slug: 'updated-category', position: 1 }
    assert_redirected_to project_category_path(assigns(:project), assigns(:category))
  end

  test "should destroy category" do
    assert_difference('Category.current.count', -1) do
      delete :destroy, project_id: @project, id: @category
    end

    assert_redirected_to project_categories_path(assigns(:project))
  end
end
