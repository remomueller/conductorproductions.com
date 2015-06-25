require 'test_helper'

class EmbedsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @embed = embeds(:one)
    login(users(:system_admin))
  end

  test "should get index" do
    get :index, project_id: @project
    assert_response :success
    assert_not_nil assigns(:embeds)
  end

  test "should get new" do
    get :new, project_id: @project
    assert_response :success
  end

  test "should create embed" do
    assert_difference('Embed.count') do
      post :create, project_id: @project, embed: { archived: @embed.archived, category_id: @embed.category_id, deleted: @embed.deleted, embed_url: @embed.embed_url, project_id: @embed.project_id, user_id: @embed.user_id }
    end

    assert_redirected_to project_embed_path(assigns(:project), assigns(:embed))
  end

  test "should show embed" do
    get :show, project_id: @project, id: @embed
    assert_response :success
  end

  test "should get edit" do
    get :edit, project_id: @project, id: @embed
    assert_response :success
  end

  test "should update embed" do
    patch :update, project_id: @project, id: @embed, embed: { archived: @embed.archived, category_id: @embed.category_id, deleted: @embed.deleted, embed_url: @embed.embed_url, project_id: @embed.project_id, user_id: @embed.user_id }
    assert_redirected_to project_embed_path(assigns(:project), assigns(:embed))
  end

  test "should destroy embed" do
    assert_difference('Embed.current.count', -1) do
      delete :destroy, project_id: @project, id: @embed
    end

    assert_redirected_to project_embeds_path(assigns(:project))
  end
end
