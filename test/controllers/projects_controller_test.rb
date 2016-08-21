# frozen_string_literal: true

require 'test_helper'

# Tests to assure projects can be created and updated.
class ProjectsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  def project_params
    {
      name: 'New Project',
      slug: 'new-project',
      agency_logo: @project.agency_logo,
      password: @project.password_plain
    }
  end

  test 'should invite new user to project' do
    login(@editor_project_one)
    assert_difference('ProjectUser.count') do
      post :invite_user,
        id: @project, editor: '1',
        invite_email: 'invite@example.com', format: 'js'
    end
    assert_not_nil assigns(:member)
    assert_not_nil assigns(:member).invite_token
    assert_template 'collaborators'
    assert_response :success
  end

  test 'should add associated user to project' do
    login(@system_admin)
    assert_difference('ProjectUser.count') do
      post :invite_user,
        id: projects(:two), editor: '1',
        invite_email: "#{users(:editor_project_one).name} [#{users(:editor_project_one).email}]", format: 'js'
    end
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:member)
    assert_template 'collaborators'
    assert_response :success
  end

  test 'should get index as system admin' do
    login(@system_admin)
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get index as editor' do
    login(@editor_project_one)
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get index as viewer' do
    login(@viewer_project_one)
    get :index
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get archived as system admin' do
    login(@system_admin)
    get :archived
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get archived as editor' do
    login(@editor_project_one)
    get :archived
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get archived as viewer' do
    login(@viewer_project_one)
    get :archived
    assert_response :success
    assert_not_nil assigns(:projects)
  end

  test 'should get new as system admin' do
    login(@system_admin)
    get :new
    assert_response :success
  end

  test 'should not get new as editor' do
    login(@editor_project_one)
    get :new
    assert_redirected_to root_path
  end

  test 'should not get new as viewer' do
    login(@viewer_project_one)
    get :new
    assert_redirected_to root_path
  end

  test 'should create project as system admin' do
    login(@system_admin)
    assert_difference('Project.count') do
      post :create, project: project_params
    end
    assert_redirected_to project_path(assigns(:project))
  end

  test 'should not create project with existing username' do
    login(@system_admin)
    assert_difference('Project.count', 0) do
      post :create, project: project_params.merge(username: 'Client')
    end
    assert_template 'new'
    assert_response :success
  end

  test 'should not create project as editor' do
    login(@editor_project_one)
    assert_difference('Project.count', 0) do
      post :create, project: project_params
    end
    assert_redirected_to root_path
  end

  test 'should not create project as viewer' do
    login(@viewer_project_one)
    assert_difference('Project.count', 0) do
      post :create, project: project_params
    end
    assert_redirected_to root_path
  end

  test 'should show project as owner' do
    login(@system_admin)
    get :show, id: @project
    assert_response :success
  end

  test 'should show project as editor' do
    login(@editor_project_one)
    get :show, id: @project
    assert_response :success
  end

  test 'should show project as viewer' do
    login(@viewer_project_one)
    get :show, id: @project
    assert_response :success
  end

  test 'should get edit as owner' do
    login(@system_admin)
    get :edit, id: @project
    assert_response :success
  end

  test 'should get edit as editor' do
    login(@editor_project_one)
    get :edit, id: @project
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer_project_one)
    get :edit, id: @project
    assert_redirected_to projects_path
  end

  test 'should update project as owner' do
    login(@system_admin)
    patch :update, id: @project, project: project_params.merge(name: 'Project Update', slug: 'project-update')
    assert_redirected_to project_path(assigns(:project))
  end

  test 'should not update project with blank name' do
    login(@system_admin)
    patch :update, id: @project, project: project_params.merge(name: '')
    assert_not_nil assigns(:project)
    assert_equal ["can't be blank"], assigns(:project).errors[:name]
    assert_template 'edit'
    assert_response :success
  end

  test 'should update project as editor' do
    login(@editor_project_one)
    patch :update, id: @project, project: project_params.merge(name: 'Project Update', slug: 'project-update')
    assert_redirected_to project_path(assigns(:project))
  end

  test 'should not update project as viewer' do
    login(@viewer_project_one)
    patch :update, id: @project, project: project_params.merge(name: 'Project Update', slug: 'project-update')
    assert_redirected_to projects_path
  end

  test 'should destroy project as system admin' do
    login(@system_admin)
    assert_difference('Project.current.count', -1) do
      delete :destroy, id: @project
    end
    assert_redirected_to projects_path
  end

  test 'should not destroy project as editor' do
    login(@editor_project_one)
    assert_difference('Project.current.count', 0) do
      delete :destroy, id: @project
    end
    assert_redirected_to projects_path
  end

  test 'should not destroy project as viewer' do
    login(@viewer_project_one)
    assert_difference('Project.current.count', 0) do
      delete :destroy, id: @project
    end
    assert_redirected_to projects_path
  end
end
