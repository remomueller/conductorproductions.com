# frozen_string_literal: true

require 'test_helper'

# Tests to assure documents can be created and modified.
class DocumentsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @document = documents(:one)
    @document2 = documents(:two)
    @system_admin = users(:system_admin)
    @editor_project_one = users(:editor_project_one)
    @viewer_project_one = users(:viewer_project_one)
  end

  test "should get index as owner" do
    login(@system_admin)
    get :index, project_id: @project
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get index as editor" do
    login(@editor_project_one)
    get :index, project_id: @project
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get index as viewer" do
    login(@viewer_project_one)
    get :index, project_id: @project
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new as owner" do
    login(@system_admin)
    get :new, project_id: @project
    assert_response :success
  end

  test "should get new as editor" do
    login(@editor_project_one)
    get :new, project_id: @project
    assert_response :success
  end

  test "should not get new as viewer" do
    login(@viewer_project_one)
    get :new, project_id: @project
    assert_redirected_to root_path
  end

  test "should create document as owner" do
    login(@system_admin)
    assert_difference('Document.count') do
      post :create, project_id: @project, document: { archived: @document.archived, category_id: @document.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    end

    assert_redirected_to project_document_path(assigns(:project), assigns(:document))
  end

  test "should create document as editor" do
    login(@editor_project_one)
    assert_difference('Document.count') do
      post :create, project_id: @project, document: { archived: @document.archived, category_id: @document.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    end

    assert_redirected_to project_document_path(assigns(:project), assigns(:document))
  end

  test "should not create document as viewer" do
    login(@viewer_project_one)
    assert_difference('Document.count', 0) do
      post :create, project_id: @project, document: { archived: @document.archived, category_id: @document.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    end

    assert_redirected_to root_path
  end

  test "should show document as owner" do
    login(@system_admin)
    get :show, project_id: @project, id: @document
    assert_response :success
  end

  test "should show document as editor" do
    login(@editor_project_one)
    get :show, project_id: @project, id: @document
    assert_response :success
  end

  test "should show document as viewer" do
    login(@viewer_project_one)
    get :show, project_id: @project, id: @document
    assert_response :success
  end

  test "should download document file as owner" do
    login(@system_admin)
    assert_not_equal 0, @document.document.size
    get :download, project_id: @project, id: @document

    assert_not_nil response
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:document)

    assert_kind_of String, response.body
    assert_equal File.binread( File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url) ), response.body
  end

  test "should download document file as editor" do
    login(@editor_project_one)
    assert_not_equal 0, @document.document.size
    get :download, project_id: @project, id: @document

    assert_not_nil response
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:document)

    assert_kind_of String, response.body
    assert_equal File.binread( File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url) ), response.body
  end

  test "should download document file as viewer" do
    login(@viewer_project_one)
    assert_not_equal 0, @document.document.size
    get :download, project_id: @project, id: @document

    assert_not_nil response
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:document)

    assert_kind_of String, response.body
    assert_equal File.binread( File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url) ), response.body
  end

  test "should get edit as owner" do
    login(@system_admin)
    get :edit, project_id: @project, id: @document
    assert_response :success
  end

  test "should get edit as editor" do
    login(@editor_project_one)
    get :edit, project_id: @project, id: @document
    assert_response :success
  end

  test "should not get edit as viewer" do
    login(@viewer_project_one)
    get :edit, project_id: @project, id: @document
    assert_redirected_to root_path
  end

  test "should update document as owner" do
    login(@system_admin)
    patch :update, project_id: @project, id: @document2, document: { archived: @document2.archived, category_id: @document2.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    assert_redirected_to project_document_path(assigns(:project), assigns(:document))
  end

  test "should update document as editor" do
    login(@editor_project_one)
    patch :update, project_id: @project, id: @document2, document: { archived: @document2.archived, category_id: @document2.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    assert_redirected_to project_document_path(assigns(:project), assigns(:document))
  end

  test "should not update document as viewer" do
    login(@viewer_project_one)
    patch :update, project_id: @project, id: @document2, document: { archived: @document2.archived, category_id: @document2.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    assert_redirected_to root_path
  end

  test "should destroy document as owner" do
    login(@system_admin)
    assert_difference('Document.current.count', -1) do
      delete :destroy, project_id: @project, id: @document
    end

    assert_redirected_to project_documents_path(assigns(:project))
  end

  test "should destroy document as editor" do
    login(@editor_project_one)
    assert_difference('Document.current.count', -1) do
      delete :destroy, project_id: @project, id: @document
    end

    assert_redirected_to project_documents_path(assigns(:project))
  end

  test "should not destroy document as viewer" do
    login(@viewer_project_one)
    assert_difference('Document.current.count', 0) do
      delete :destroy, project_id: @project, id: @document
    end

    assert_redirected_to root_path
  end

end
