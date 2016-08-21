# frozen_string_literal: true

# Allows photos to be added to locations.
class LocationPhotosController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show, :download]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy] #, :upload_photos
  before_action :redirect_without_project

  before_action :set_location
  before_action :redirect_without_location

  before_action :set_location_photo,                        only: [:show, :download, :edit, :update, :destroy]
  before_action :redirect_without_location_location_photo,  only: [:show, :download, :edit, :update, :destroy]

  # # GET /location_photos
  # # GET /location_photos.json
  # def index
  #   @location_photos = LocationPhoto.all
  # end

  def download
    if params[:size] == 'preview'
      send_file File.join( CarrierWave::Uploader::Base.root, @location_photo.photo.preview.url )
    elsif params[:size] == 'thumb'
      send_file File.join( CarrierWave::Uploader::Base.root, @location_photo.photo.thumb.url )
    else
      send_file File.join( CarrierWave::Uploader::Base.root, @location_photo.photo.url )
    end
  end

  # GET /location_photos/1
  # GET /location_photos/1.json
  def show
  end

  # # GET /location_photos/new
  # def new
  #   @location_photo = LocationPhoto.new
  # end

  # # GET /location_photos/1/edit
  # def edit
  # end

  # # POST /location_photos
  # # POST /location_photos.json
  # def create
  #   @location_photo = LocationPhoto.new(location_photo_params)

  #   respond_to do |format|
  #     if @location_photo.save
  #       format.html { redirect_to @location_photo, notice: 'Location photo was successfully created.' }
  #       format.json { render :show, status: :created, location: @location_photo }
  #     else
  #       format.html { render :new }
  #       format.json { render json: @location_photo.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # # PATCH/PUT /location_photos/1
  # # PATCH/PUT /location_photos/1.json
  # def update
  #   respond_to do |format|
  #     if @location_photo.update(location_photo_params)
  #       format.html { redirect_to @location_photo, notice: 'Location photo was successfully updated.' }
  #       format.json { render :show, status: :ok, location: @location_photo }
  #     else
  #       format.html { render :edit }
  #       format.json { render json: @location_photo.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  # DELETE /location_photos/1
  # DELETE /location_photos/1.json
  def destroy
    @location_photo.destroy
    respond_to do |format|
      format.html { redirect_to [@project, @location], notice: 'Location photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = @project.locations.find_by_param(params[:location_id])
    end

    def redirect_without_location
      empty_response_or_root_path(project_locations_path(@project)) unless @location
    end

    def set_location_photo
      @location_photo = @location.location_photos.find_by_id(params[:id])
    end

    def redirect_without_location_location_photo
      empty_response_or_root_path(project_location_path(@project, @location)) unless @location_photo
    end

    def location_photo_params
      params.require(:location_photo).permit(:photo)
    end
end
