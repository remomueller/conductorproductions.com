# frozen_string_literal: true

# Allows creation of galleries.
class GalleriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_viewable_project_or_redirect, only: [:index, :show]
  before_action :find_editable_project_or_redirect, only: [
    :new, :create, :edit, :update, :destroy, :upload_photos, :save_photo_order
  ]
  before_action :find_gallery_or_redirect, only: [
    :show, :edit, :update, :destroy, :upload_photos, :save_photo_order
  ]

  layout "layouts/full_page_sidebar2"

  # POST /galleries/1/save_photo_order.js
  def save_photo_order
    params[:gallery_photo_ids].each_with_index do |gallery_photo_id, index|
      gallery_photo = @gallery.gallery_photos.find_by_id gallery_photo_id
      if gallery_photo
        gallery_photo.update position: index
      end
    end
    head :ok
  end

  # PATCH /galleries/1/upload_photos.js
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
    @gallery = @project.galleries.new(category_id: params[:category_id])
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
  # PATCH /galleries/1.js
  def update
    if @gallery.update(gallery_params)
      respond_to do |format|
        format.html { redirect_to [@project, @gallery], notice: 'Gallery was successfully updated.' }
        format.js
      end
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

  def find_gallery_or_redirect
    @gallery = @project.galleries.find_by_param params[:id]
    redirect_without_gallery
  end

  def redirect_without_gallery
    empty_response_or_root_path(project_galleries_path(@project)) unless @gallery
  end

  def gallery_params
    params.require(:gallery).permit(:category_id, :name, :slug, :address, :archived)
  end
end
