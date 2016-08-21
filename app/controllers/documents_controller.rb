# frozen_string_literal: true

# Allows documents to be added to categories.
class DocumentsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show, :download]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_without_project

  before_action :set_document, only: [:show, :download, :edit, :update, :destroy]
  before_action :redirect_without_document, only: [:show, :download, :edit, :update, :destroy]

  # GET /documents
  # GET /documents.json
  def index
    @documents = @project.documents
  end

  # GET /documents/1
  # GET /documents/1.json
  def show
  end

  def download
    if @document.document.size > 0
      send_file File.join( CarrierWave::Uploader::Base.root, @document.document.url )
    else
      head :ok
    end
  end

  # GET /documents/new
  def new
    @document = @project.documents.new
  end

  # GET /documents/1/edit
  def edit
  end

  # POST /documents
  # POST /documents.json
  def create
    @document = current_user.documents.where(project_id: @project.id).new(document_params)

    respond_to do |format|
      if @document.save
        format.html { redirect_to [@project, @document], notice: 'Document was successfully created.' }
        format.json { render :show, status: :created, location: @document }
      else
        format.html { render :new }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /documents/1
  # PATCH/PUT /documents/1.json
  def update
    respond_to do |format|
      if @document.update(document_params)
        format.html { redirect_to [@project, @document], notice: 'Document was successfully updated.' }
        format.json { render :show, status: :ok, location: @document }
      else
        format.html { render :edit }
        format.json { render json: @document.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /documents/1
  # DELETE /documents/1.json
  def destroy
    @document.destroy
    respond_to do |format|
      format.html { redirect_to project_documents_path(@project), notice: 'Document was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_document
      @document = @project.documents.find_by_id(params[:id])
    end

    def redirect_without_document
      empty_response_or_root_path(project_documents_path(@project)) unless @document
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def document_params
      params[:document] ||= { blank: '1' }
      params[:document][:document_uploaded_at] = Time.zone.now if params[:document][:document].present?
      params.require(:document).permit(:category_id, :document, :document_uploaded_at, :document_cache, :archived)
    end
end
