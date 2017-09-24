# frozen_string_literal: true

require 'test_helper'

# Tests to assure that public pages are viewable.
class WelcomeControllerTest < ActionController::TestCase
  test 'should get index' do
    skip
    get :index
    assert_response :success
  end

  test 'should get index as client' do
    skip
    login_client(@client)
    get :index
    assert_response :success
  end

  test 'should get index as system admin' do
    skip
    login(@system_admin)
    get :index
    assert_response :success
  end

  test 'should get index as collaborator' do
    skip
    login(@collaborator)
    get :index
    assert_response :success
  end

  test 'should get work' do
    skip
    get :work
    assert_response :success
  end

  test 'should get work as client' do
    skip
    login_client(@client)
    get :work
    assert_response :success
  end

  test 'should get work as system admin' do
    skip
    login(@system_admin)
    get :work
    assert_response :success
  end

  test 'should get work as collaborator' do
    skip
    login(@collaborator)
    get :work
    assert_response :success
  end

  test 'should get drtv' do
    skip
    get :drtv
    assert_redirected_to work_path
    # assert_response :success
  end

  test 'should get drtv as client' do
    skip
    login_client(@client)
    get :drtv
    assert_redirected_to work_path
    # assert_response :success
  end

  test 'should get drtv as system admin' do
    skip
    login(@system_admin)
    get :drtv
    assert_redirected_to work_path
    # assert_response :success
  end

  test 'should get drtv as collaborator' do
    skip
    login(@collaborator)
    get :drtv
    assert_redirected_to work_path
    # assert_response :success
  end

  test 'should get contact' do
    skip
    get :contact
    assert_response :success
  end

  test 'should get contact as client' do
    skip
    login_client(@client)
    get :contact
    assert_response :success
  end

  test 'should get contact as system admin' do
    skip
    login(@system_admin)
    get :contact
    assert_response :success
  end

  test 'should get contact as collaborator' do
    skip
    login(@collaborator)
    get :contact
    assert_response :success
  end

  test 'should get year in review' do
    skip
    get :year_in_review
    assert_response :success
  end

  # Older versions

  # test 'should get about' do
  #   get :about
  #   assert_response :success
  # end

  # test 'should get clients' do
  #   get :clients
  #   assert_response :success
  # end

  # test 'should get news' do
  #   get :news
  #   assert_response :success
  # end

  # test 'should get index_v1' do
  #   get :index_v1
  #   assert_response :success
  # end

  # test 'should get index_v2' do
  #   get :index_v2
  #   assert_response :success
  # end
end
