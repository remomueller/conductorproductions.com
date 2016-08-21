# frozen_string_literal: true

require 'test_helper'

# Tests to make sure users can be successfully invited to projects.
class ProjectUsersControllerTest < ActionController::TestCase
  setup do
    login(users(:editor_project_one))
    @pending_editor_invite = project_users(:pending_editor_invite)
    @accepted_viewer_invite = project_users(:accepted_viewer_invite)
  end

  test 'should resend project invitation' do
    post :resend, id: @pending_editor_invite
    assert_not_nil assigns(:project_user)
    assert_not_nil assigns(:project)
    assert_redirected_to collaborators_project_path(assigns(:project))
  end

  test 'should not resend project invitation with invalid id' do
    post :resend, id: -1
    assert_nil assigns(:project_user)
    assert_nil assigns(:project)
    assert_redirected_to root_path
  end

  test 'should accept project user' do
    login(users(:collaborator))
    session[:invite_token] = @pending_editor_invite.invite_token
    get :accept
    assert_not_nil assigns(:project_user)
    assert_equal users(:collaborator), assigns(:project_user).user
    assert_equal 'You have been successfully been added to the project.', flash[:notice]
    assert_redirected_to assigns(:project_user).project
  end

  test 'should accept existing project user' do
    session[:invite_token] = project_users(:accepted_editor_invite).invite_token
    get :accept
    assert_not_nil assigns(:project_user)
    assert_equal users(:editor_project_one), assigns(:project_user).user
    assert_equal "You have already been added to #{assigns(:project_user).project.name}.", flash[:notice]
    assert_redirected_to assigns(:project_user).project
  end

  test 'should not accept invalid token for project user' do
    session[:invite_token] = 'imaninvalidtoken'
    get :accept
    assert_nil assigns(:project_user)
    assert_equal 'Invalid invitation token.', flash[:alert]
    assert_redirected_to root_path
  end

  test 'should not accept project user if invite token is already claimed' do
    login(users(:collaborator))
    session[:invite_token] = 'accepted_viewer_invite'
    get :accept
    assert_not_nil assigns(:project_user)
    assert_not_equal users(:collaborator), assigns(:project_user).user
    assert_equal 'This invite has already been claimed.', flash[:alert]
    assert_redirected_to root_path
  end

  test 'should destroy project user' do
    assert_difference('ProjectUser.count', -1) do
      delete :destroy, id: @accepted_viewer_invite, format: 'js'
    end
    assert_not_nil assigns(:project)
    assert_template 'projects/collaborators'
  end

  test 'should allow viewer to remove self from project' do
    login(users(:viewer_project_one))
    assert_difference('ProjectUser.count', -1) do
      delete :destroy, id: @accepted_viewer_invite, format: 'js'
    end
    assert_not_nil assigns(:project)
    assert_template 'projects/collaborators'
  end

  test 'should not destroy project user with invalid id' do
    assert_difference('ProjectUser.count', 0) do
      delete :destroy, id: -1, format: 'js'
    end
    assert_nil assigns(:project)
    assert_response :success
  end
end
