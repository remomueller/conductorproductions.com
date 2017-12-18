# frozen_string_literal: true

# Allows documents to be added to categories.
class DocumentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show, :download_primary, :download]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_without_project

  before_action :set_document, only: [:show, :download_primary, :download, :edit, :update, :destroy]
  before_action :redirect_without_document, only: [:show, :download_primary, :download, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar2"

  # GET /documents
  def index
    @documents = @project.documents
  end

  # GET /documents/1
  def show
  end

  def download_primary
    if @document.primary_document.size > 0
      send_file File.join(CarrierWave::Uploader::Base.root, @document.primary_document.url)
    else
      head :ok
    end
  end

  def download
    if @document.document.size > 0
      send_file File.join(CarrierWave::Uploader::Base.root, @document.document.url)
    else
      head :ok
    end
  end

  # GET /documents/new
  def new
    @document = @project.documents.new(category_id: params[:category_id])
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  def create
    @document = current_user.documents.where(project_id: @project.id).new(document_params)

    if @document.save
      redirect_to [@project, @document], notice: "Document was successfully created."
    else
      render :new
    end
  end

  # PATCH /documents/1
  # PATCH /documents/1.js
  def update
    if @document.update(document_params)
      respond_to do |format|
        format.html { redirect_to [@project, @document], notice: "Document was successfully updated." }
        format.js
      end
    else
      render :edit
    end
  end

  # DELETE /documents/1
  def destroy
    @document.destroy
    redirect_to project_documents_path(@project), notice: "Document was successfully deleted."
  end

  private

  def set_document
    @document = @project.documents.find_by_id(params[:id])
  end

  def redirect_without_document
    empty_response_or_root_path(project_documents_path(@project)) unless @document
  end

  def document_params
    params[:document] ||= { blank: "1" }
    params[:document][:document_uploaded_at] = Time.zone.now if params[:document][:primary_document].present?
    params.require(:document).permit(
      :category_id, :primary_document, :primary_document_cache,
      :document, :document_uploaded_at, :document_cache,
      :archived
    )
  end
end
