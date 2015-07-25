require 'test_helper'

class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  test "should get index as system admin" do
    login(@system_admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get index as editor" do
    login(@editor_project_one)
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get index as viewer" do
    login(@viewer_project_one)
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test "should get new as system admin" do
    login(@system_admin)
    get :new
    assert_response :success
  end

  test "should not get new as editor" do
    login(@editor_project_one)
    get :new
    assert_redirected_to root_path
  end

  test "should not get new as viewer" do
    login(@viewer_project_one)
    get :new
    assert_redirected_to root_path
  end

  test "should create project as system admin" do
    login(@system_admin)
    assert_difference('Project.count') do
      post :create, project: { name: 'New Project', slug: 'new-project', agency_logo: @project.agency_logo, password: @project.password_plain }
    end

    assert_redirected_to project_path(assigns(:project))
  end

  test "should not create project as editor" do
    login(@editor_project_one)
    assert_difference('Project.count', 0) do
      post :create, project: { name: 'New Project', slug: 'new-project', agency_logo: @project.agency_logo, password: @project.password_plain }
    end

    assert_redirected_to root_path
  end

  test "should not create project as viewer" do
    login(@viewer_project_one)
    assert_difference('Project.count', 0) do
      post :create, project: { name: 'New Project', slug: 'new-project', agency_logo: @project.agency_logo, password: @project.password_plain }
    end

    assert_redirected_to root_path
  end

  test "should show project as owner" do
    login(@system_admin)
    get :show, id: @project
    assert_response :success
  end

  test "should show project as editor" do
    login(@editor_project_one)
    get :show, id: @project
    assert_response :success
  end

  test "should show project as viewer" do
    login(@viewer_project_one)
    get :show, id: @project
    assert_response :success
  end

  test "should get edit as owner" do
    login(@system_admin)
    get :edit, id: @project
    assert_response :success
  end

  test "should get edit as editor" do
    login(@editor_project_one)
    get :edit, id: @project
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer_project_one)
    get :edit, id: @project
    assert_redirected_to projects_path
  end

  test "should update project as owner" do
    login(@system_admin)
    patch :update, id: @project, project: { name: 'Project Update', slug: 'project-update', agency_logo: @project.agency_logo, password: @project.password_plain }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should update project as editor" do
    login(@editor_project_one)
    patch :update, id: @project, project: { name: 'Project Update', slug: 'project-update', agency_logo: @project.agency_logo, password: @project.password_plain }
    assert_redirected_to project_path(assigns(:project))
  end

  test "should not update project as viewer" do
    login(@viewer_project_one)
    patch :update, id: @project, project: { name: 'Project Update', slug: 'project-update', agency_logo: @project.agency_logo, password: @project.password_plain }
    assert_redirected_to projects_path
  end

  test "should destroy project as system admin" do
    login(@system_admin)
    assert_difference('Project.current.count', -1) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end

  test "should not destroy project as editor" do
    login(@editor_project_one)
    assert_difference('Project.current.count', 0) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end

  test "should not destroy project as viewer" do
    login(@viewer_project_one)
    assert_difference('Project.current.count', 0) do
      delete :destroy, id: @project
    end

    assert_redirected_to projects_path
  end
end
