require 'test_helper'

class VideosControllerTest < ActionController::TestCase
  setup do
    @video = videos(:work_one)
    @video_drtv = videos(:drtv_one)
    @system_admin = users(:system_admin)
    @regular = users(:regular)
  end

  test "should get reorder as system admin" do
    login(@system_admin)
    get :reorder, video_page: 'work'
    assert_not_nil assigns(:videos)
    assert_response :success
  end

  test "should get reorder as regular user" do
    login(@regular)
    get :reorder, video_page: 'work'
    assert_nil assigns(:videos)
    assert_redirected_to root_path
  end

  test "should reorder videos as system admin" do
    login(@system_admin)
    xhr :post, :save_video_order, video_page: 'work', video_ids: [videos(:work_two).to_param, videos(:work_one).to_param], format: 'js'
    videos(:work_one).reload
    videos(:work_two).reload
    videos(:work_archived).reload
    videos(:drtv_one).reload
    assert_equal 0, videos(:work_two).position
    assert_equal 1, videos(:work_one).position
    assert_equal 9, videos(:work_archived).position
    assert_equal 0, videos(:drtv_one).position
    assert_response :success
  end

  test "should reorder videos as regular user" do
    login(@regular)
    xhr :post, :save_video_order, video_page: 'work', video_ids: [videos(:work_two).to_param, videos(:work_one).to_param], format: 'js'
    videos(:work_one).reload
    videos(:work_two).reload
    videos(:work_archived).reload
    videos(:drtv_one).reload
    assert_equal 0, videos(:work_one).position
    assert_equal 1, videos(:work_two).position
    assert_equal 9, videos(:work_archived).position
    assert_equal 0, videos(:drtv_one).position
    assert_redirected_to root_path
  end

  test "should get index as system admin" do
    login(@system_admin)
    get :index
    assert_not_nil assigns(:videos)
    assert_response :success
  end

  test "should not get index as regular user" do
    login(@regular)
    get :index
    assert_nil assigns(:videos)
    assert_redirected_to root_path
  end

  test "should get new as system admin" do
    login(@system_admin)
    get :new
    assert_response :success
  end

  test "should not get new as regular user" do
    login(@regular)
    get :new
    assert_redirected_to root_path
  end

  test "should create video as system admin" do
    login(@system_admin)
    assert_difference('Video.count') do
      post :create, video: { video_page: @video.video_page, vimeo_number: '124955435', photo: fixture_file_upload('../../test/support/projects/rails.png'), position: @video.position, archived: @video.archived }
    end

    assert_not_nil assigns(:video)
    assert_redirected_to video_path(assigns(:video))
  end

  test "should not create video as regular user" do
    login(@regular)
    assert_difference('Video.count', 0) do
      post :create, video: { video_page: @video.video_page, vimeo_number: '124955435', photo: fixture_file_upload('../../test/support/projects/rails.png'), position: @video.position, archived: @video.archived }
    end

    assert_nil assigns(:video)
    assert_redirected_to root_path
  end

  test "should show video as system admin" do
    login(@system_admin)
    get :show, id: @video
    assert_response :success
  end

  test "should not show video as regular user" do
    login(@regular)
    get :show, id: @video
    assert_redirected_to root_path
  end

  test "should get edit as system admin" do
    login(@system_admin)
    get :edit, id: @video
    assert_response :success
  end

  test "should not get edit as regular user" do
    login(@regular)
    get :edit, id: @video
    assert_redirected_to root_path
  end

  test "should update video as system admin" do
    login(@system_admin)
    patch :update, id: @video_drtv, video: { video_page: @video_drtv.video_page, vimeo_number: @video_drtv.vimeo_number, photo: fixture_file_upload('../../test/support/projects/rails.png'), archived: @video_drtv.archived }
    assert_redirected_to video_path(assigns(:video))
  end

  test "should update video as regular user" do
    login(@regular)
    patch :update, id: @video_drtv, video: { video_page: @video_drtv.video_page, vimeo_number: @video_drtv.vimeo_number, photo: fixture_file_upload('../../test/support/projects/rails.png'), archived: @video_drtv.archived }
    assert_redirected_to root_path
  end

  test "should destroy video as system admin" do
    login(@system_admin)
    assert_difference('Video.current.count', -1) do
      delete :destroy, id: @video
    end

    assert_redirected_to videos_path
  end

  test "should destroy video as regular user" do
    login(@regular)
    assert_difference('Video.current.count', 0) do
      delete :destroy, id: @video
    end

    assert_redirected_to root_path
  end
end
