require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:regular)
    @client = projects(:one)
    @system_admin = users(:system_admin)
    @collaborator = users(:collaborator)
  end

  test "should get index as system admin" do
    login(@system_admin)
    get :index
    assert_not_nil assigns(:users)
    assert_response :success
  end

  test "should not get index as collaborator" do
    login(@collaborator)
    get :index
    assert_nil assigns(:users)
    assert_redirected_to root_path
  end

  test "should not get index as client" do
    login_client(@client)
    get :index
    assert_nil assigns(:users)
    assert_redirected_to new_user_session_path
  end

  test "should not get index as logged out user" do
    get :index
    assert_nil assigns(:users)
    assert_redirected_to new_user_session_path
  end

  test "should show user as system admin" do
    login(@system_admin)
    get :show, id: @user
    assert_response :success
  end

  test "should not show user as collaborator" do
    login(@collaborator)
    get :show, id: @user
    assert_redirected_to root_path
  end

  test "should not show user as client" do
    login_client(@client)
    get :show, id: @user
    assert_redirected_to new_user_session_path
  end

  test "should not show user as logged out user" do
    get :show, id: @user
    assert_redirected_to new_user_session_path
  end

  test "should get edit as system admin" do
    login(@system_admin)
    get :edit, id: @user
    assert_response :success
  end

  test "should not get edit as collaborator" do
    login(@collaborator)
    get :edit, id: @user
    assert_redirected_to root_path
  end

  test "should not get edit as client" do
    login_client(@client)
    get :edit, id: @user
    assert_redirected_to new_user_session_path
  end

  test "should not get edit as logged out user" do
    get :edit, id: @user
    assert_redirected_to new_user_session_path
  end

  test "should update user as system admin" do
    login(@system_admin)
    patch :update, id: @user, user: { first_name: 'User Update', last_name: 'User Update', system_admin: false }
    assert_redirected_to user_path(assigns(:user))
  end

  test "should not update user as collaborator" do
    login(@collaborator)
    patch :update, id: @user, user: { first_name: 'User Update', last_name: 'User Update', system_admin: false }
    assert_redirected_to root_path
  end

  test "should not update user as client" do
    login_client(@client)
    patch :update, id: @user, user: { first_name: 'User Update', last_name: 'User Update', system_admin: false }
    assert_redirected_to new_user_session_path
  end

  test "should not update user as logged out user" do
    patch :update, id: @user, user: { first_name: 'User Update', last_name: 'User Update', system_admin: false }
    assert_redirected_to new_user_session_path
  end

  test "should destroy user as system admin" do
    login(@system_admin)
    assert_difference('User.current.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end

  test "should not destroy user as collaborator" do
    login(@collaborator)
    assert_difference('User.current.count', 0) do
      delete :destroy, id: @user
    end

    assert_redirected_to root_path
  end

  test "should not destroy user as client" do
    login_client(@client)
    assert_difference('User.current.count', 0) do
      delete :destroy, id: @user
    end

    assert_redirected_to new_user_session_path
  end

  test "should not destroy user as logged out user" do
    assert_difference('User.current.count', 0) do
      delete :destroy, id: @user
    end

    assert_redirected_to new_user_session_path
  end
end
