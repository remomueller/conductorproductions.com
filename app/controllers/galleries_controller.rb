# frozen_string_literal: true

# Allows creation of galleries.
class GalleriesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy, :upload_photos]
  before_action :redirect_without_project

  before_action :set_gallery,              only: [:show, :edit, :update, :destroy, :upload_photos]
  before_action :redirect_without_gallery, only: [:show, :edit, :update, :destroy, :upload_photos]

  def upload_photos
    params[:photos].each do |photo|
      @gallery.gallery_photos.create(project_id: @project.id, user_id: current_user.id, photo: photo)
    end
  end

  # GET /galleries
  def index
    @galleries = @project.galleries
  end

  # GET /galleries/1
  def show
  end

  # GET /galleries/new
  def new
    @gallery = @project.galleries.new
  end

  # GET /galleries/1/edit
  def edit
  end

  # POST /galleries
  def create
    @gallery = current_user.galleries.where(project_id: @project.id).new(gallery_params)
    if @gallery.save
      redirect_to [@project, @gallery], notice: 'Gallery was successfully created.'
    else
      render :new
    end
  end

  # PATCH /galleries/1
  def update
    if @gallery.update(gallery_params)
      redirect_to [@project, @gallery], notice: 'Gallery was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /galleries/1
  def destroy
    @gallery.destroy
    redirect_to project_galleries_path(@project), notice: 'Gallery was successfully deleted.'
  end

  private

  def set_gallery
    @gallery = @project.galleries.find_by_param(params[:id])
  end

  def redirect_without_gallery
    empty_response_or_root_path(project_galleries_path(@project)) unless @gallery
  end

  def gallery_params
    params.require(:gallery).permit(:category_id, :name, :slug, :address, :archived)
  end
end
