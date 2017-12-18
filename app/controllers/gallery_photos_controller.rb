# frozen_string_literal: true

# Allows photos to be added to galleries.
class GalleryPhotosController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show, :download]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy] #, :upload_photos
  before_action :redirect_without_project

  before_action :set_gallery
  before_action :redirect_without_gallery

  before_action :set_gallery_photo,                        only: [:show, :download, :edit, :update, :destroy]
  before_action :redirect_without_gallery_gallery_photo,  only: [:show, :download, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar2"

  # # GET /gallery_photos
  # def index
  #   @gallery_photos = GalleryPhoto.all
  # end

  def download
    if params[:size] == 'preview'
      send_file File.join( CarrierWave::Uploader::Base.root, @gallery_photo.photo.preview.url )
    elsif params[:size] == 'thumb'
      send_file File.join( CarrierWave::Uploader::Base.root, @gallery_photo.photo.thumb.url )
    else
      send_file File.join( CarrierWave::Uploader::Base.root, @gallery_photo.photo.url )
    end
  end

  # GET /gallery_photos/1
  def show
  end

  # # GET /gallery_photos/new
  # def new
  #   @gallery_photo = GalleryPhoto.new
  # end

  # # GET /gallery_photos/1/edit
  # def edit
  # end

  # # POST /gallery_photos
  # def create
  #   @gallery_photo = GalleryPhoto.new(gallery_photo_params)

  #   if @gallery_photo.save
  #     redirect_to @gallery_photo, notice: 'Gallery photo was successfully created.'
  #   else
  #     render :new
  #   end
  # end

  # # PATCH /gallery_photos/1
  # def update
  #   if @gallery_photo.update(gallery_photo_params)
  #     redirect_to @gallery_photo, notice: 'Gallery photo was successfully updated.'
  #   else
  #     render :edit
  #   end
  # end

  # DELETE /gallery_photos/1
  def destroy
    @gallery_photo.destroy
    redirect_to [@project, @gallery], notice: 'Gallery photo was successfully deleted.'
  end

  private

  def set_gallery
    @gallery = @project.galleries.find_by_param(params[:gallery_id])
  end

  def redirect_without_gallery
    empty_response_or_root_path(project_galleries_path(@project)) unless @gallery
  end

  def set_gallery_photo
    @gallery_photo = @gallery.gallery_photos.find_by_id(params[:id])
  end

  def redirect_without_gallery_gallery_photo
    empty_response_or_root_path(project_gallery_path(@project, @gallery)) unless @gallery_photo
  end

  def gallery_photo_params
    params.require(:gallery_photo).permit(:photo)
  end
end
