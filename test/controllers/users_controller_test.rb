# frozen_string_literal: true

require 'test_helper'

# Tests to assure that user roles can be set.
class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:regular)
    @client = projects(:one)
    @system_admin = users(:system_admin)
    @collaborator = users(:collaborator)
  end

  def user_params
    {
      first_name: 'User Update',
      last_name: 'User Update',
      system_admin: false
    }
  end

  test 'should get index as system admin' do
    login(@system_admin)
    get :index
    assert_not_nil assigns(:users)
    assert_response :success
  end

  test 'should not get index as collaborator' do
    login(@collaborator)
    get :index
    assert_nil assigns(:users)
    assert_redirected_to root_path
  end

  test 'should not get index as client' do
    login_client(@client)
    get :index
    assert_nil assigns(:users)
    assert_redirected_to new_user_session_path
  end

  test 'should not get index as logged out user' do
    get :index
    assert_nil assigns(:users)
    assert_redirected_to new_user_session_path
  end

  test 'should show user as system admin' do
    login(@system_admin)
    get :show, params: { id: @user }
    assert_response :success
  end

  test 'should not show user as collaborator' do
    login(@collaborator)
    get :show, params: { id: @user }
    assert_redirected_to root_path
  end

  test 'should not show user as client' do
    login_client(@client)
    get :show, params: { id: @user }
    assert_redirected_to new_user_session_path
  end

  test 'should not show user as logged out user' do
    get :show, params: { id: @user }
    assert_redirected_to new_user_session_path
  end

  test 'should get edit as system admin' do
    login(@system_admin)
    get :edit, params: { id: @user }
    assert_response :success
  end

  test 'should not get edit as collaborator' do
    login(@collaborator)
    get :edit, params: { id: @user }
    assert_redirected_to root_path
  end

  test 'should not get edit as client' do
    login_client(@client)
    get :edit, params: { id: @user }
    assert_redirected_to new_user_session_path
  end

  test 'should not get edit as logged out user' do
    get :edit, params: { id: @user }
    assert_redirected_to new_user_session_path
  end

  test 'should update user as system admin' do
    login(@system_admin)
    patch :update, params: { id: @user, user: user_params }
    assert_redirected_to user_path(assigns(:user))
  end

  test 'should not update user as collaborator' do
    login(@collaborator)
    patch :update, params: { id: @user, user: user_params }
    assert_redirected_to root_path
  end

  test 'should not update user as client' do
    login_client(@client)
    patch :update, params: { id: @user, user: user_params }
    assert_redirected_to new_user_session_path
  end

  test 'should not update user as logged out user' do
    patch :update, params: { id: @user, user: user_params }
    assert_redirected_to new_user_session_path
  end

  test 'should destroy user as system admin' do
    login(@system_admin)
    assert_difference('User.current.count', -1) do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to users_path
  end

  test 'should not destroy user as collaborator' do
    login(@collaborator)
    assert_difference('User.current.count', 0) do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to root_path
  end

  test 'should not destroy user as client' do
    login_client(@client)
    assert_difference('User.current.count', 0) do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to new_user_session_path
  end

  test 'should not destroy user as logged out user' do
    assert_difference('User.current.count', 0) do
      delete :destroy, params: { id: @user }
    end
    assert_redirected_to new_user_session_path
  end
end
