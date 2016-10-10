# frozen_string_literal: true

require 'test_helper'

# Tests to assure embeds can be created and modified.
class EmbedsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @embed = embeds(:one)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  def embed_params
    {
      archived: @embed.archived,
      category_id: @embed.category_id,
      embed_url: @embed.embed_url,
      project_id: @embed.project_id,
      user_id: @embed.user_id
    }
  end

  test 'should get index as owner' do
    login(@system_admin)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:embeds)
  end

  test 'should get index as editor' do
    login(@editor_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:embeds)
  end

  test 'should get index as viewer' do
    login(@viewer_project_one)
    get :index, params: { project_id: @project }
    assert_response :success
    assert_not_nil assigns(:embeds)
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

  test 'should create embed as owner' do
    login(@system_admin)
    assert_difference('Embed.count') do
      post :create, params: { project_id: @project, embed: embed_params }
    end
    assert_redirected_to project_embed_path(assigns(:project), assigns(:embed))
  end

  test 'should create embed as editor' do
    login(@editor_project_one)
    assert_difference('Embed.count') do
      post :create, params: { project_id: @project, embed: embed_params }
    end
    assert_redirected_to project_embed_path(assigns(:project), assigns(:embed))
  end

  test 'should not create embed as viewer' do
    login(@viewer_project_one)
    assert_difference('Embed.count', 0) do
      post :create, params: { project_id: @project, embed: embed_params }
    end
    assert_redirected_to root_path
  end

  test 'should show embed as owner' do
    login(@system_admin)
    get :show, params: { project_id: @project, id: @embed }
    assert_response :success
  end

  test 'should show embed as editor' do
    login(@editor_project_one)
    get :show, params: { project_id: @project, id: @embed }
    assert_response :success
  end

  test 'should show embed as viewer' do
    login(@viewer_project_one)
    get :show, params: { project_id: @project, id: @embed }
    assert_response :success
  end

  test 'should get edit as owner' do
    login(@system_admin)
    get :edit, params: { project_id: @project, id: @embed }
    assert_response :success
  end

  test 'should get edit as editor' do
    login(@editor_project_one)
    get :edit, params: { project_id: @project, id: @embed }
    assert_response :success
  end

  test 'should not get edit as viewer' do
    login(@viewer_project_one)
    get :edit, params: { project_id: @project, id: @embed }
    assert_redirected_to root_path
  end

  test 'should update embed as owner' do
    login(@system_admin)
    patch :update, params: { project_id: @project, id: @embed, embed: embed_params }
    assert_redirected_to project_embed_path(assigns(:project), assigns(:embed))
  end

  test 'should update embed as editor' do
    login(@editor_project_one)
    patch :update, params: { project_id: @project, id: @embed, embed: embed_params }
    assert_redirected_to project_embed_path(assigns(:project), assigns(:embed))
  end

  test 'should update embed as editor with ajax' do
    login(@editor_project_one)
    patch :update, params: { project_id: @project, id: @embed, embed: embed_params }, format: 'js'
    assert_template 'update'
    assert_response :success
  end

  test 'should not update embed as viewer' do
    login(@viewer_project_one)
    patch :update, params: { project_id: @project, id: @embed, embed: embed_params }
    assert_redirected_to root_path
  end

  test 'should destroy embed as owner' do
    login(@system_admin)
    assert_difference('Embed.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @embed }
    end
    assert_redirected_to project_embeds_path(assigns(:project))
  end

  test 'should destroy embed as editor' do
    login(@editor_project_one)
    assert_difference('Embed.current.count', -1) do
      delete :destroy, params: { project_id: @project, id: @embed }
    end
    assert_redirected_to project_embeds_path(assigns(:project))
  end

  test 'should not destroy embed as viewer' do
    login(@viewer_project_one)
    assert_difference('Embed.current.count', 0) do
      delete :destroy, params: { project_id: @project, id: @embed }
    end
    assert_redirected_to root_path
  end
end
