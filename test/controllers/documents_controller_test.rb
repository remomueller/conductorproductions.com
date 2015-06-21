require 'test_helper'

class DocumentsControllerTest < ActionController::TestCase
  setup do
    @project = projects(:one)
    @document = documents(:one)
    @document2 = documents(:two)
    login(users(:system_admin))
  end

  test "should get index" do
    get :index, project_id: @project
    assert_response :success
    assert_not_nil assigns(:documents)
  end

  test "should get new" do
    get :new, project_id: @project
    assert_response :success
  end

  test "should create document" do
    assert_difference('Document.count') do
      post :create, project_id: @project, document: { archived: @document.archived, category_id: @document.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    end

    assert_redirected_to project_document_path(assigns(:project), assigns(:document))
  end

  test "should show document" do
    get :show, project_id: @project, id: @document
    assert_response :success
  end

  test "should download document file" do
    assert_not_equal 0, @document.document.size
    get :download, project_id: @project, id: @document

    assert_not_nil response
    assert_not_nil assigns(:project)
    assert_not_nil assigns(:document)

    assert_kind_of String, response.body
    assert_equal File.binread( File.join(CarrierWave::Uploader::Base.root, assigns(:document).document.url) ), response.body
  end

  test "should get edit" do
    get :edit, project_id: @project, id: @document
    assert_response :success
  end

  test "should update document" do

    patch :update, project_id: @project, id: @document2, document: { archived: @document2.archived, category_id: @document2.category_id, document: fixture_file_upload('../../test/support/documents/test_01.doc') }
    assert_redirected_to project_document_path(assigns(:project), assigns(:document))
  end

  test "should destroy document" do
    assert_difference('Document.current.count', -1) do
      delete :destroy, project_id: @project, id: @document
    end

    assert_redirected_to project_documents_path(assigns(:project))
  end
end
