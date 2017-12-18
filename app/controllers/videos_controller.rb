# frozen_string_literal: true

# Allows videos to be added to DRTV and Work pages.
class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin
  before_action :find_video_or_redirect, only: [:show, :edit, :update, :destroy]

  layout "layouts/full_page_sidebar2"

  # GET /videos
  def index
    @videos = Video.current.order(:archived, :video_page, :position).page(params[:page]).per(20)
  end

  def reorder
    @video_page = params[:video_page]
    @videos = Video.current.where(video_page: @video_page, archived: false).order(:position)
  end

  # POST /videos/save_video_order.js
  def save_video_order
    params[:video_ids].each_with_index do |video_id, index|
      video = Video.current.where(video_page: params[:video_page]).find_by(id: video_id)
      video.update position: index if video
    end
    head :ok
  end

  # GET /videos/1
  def show
  end

  # GET /videos/new
  def new
    @video = current_user.videos.new
  end

  # GET /videos/1/edit
  def edit
  end

  # POST /videos
  def create
    @video = current_user.videos.new(video_params)
    if @video.save
      redirect_to @video, notice: "Video was successfully created."
    else
      render :new
    end
  end

  # PATCH /videos/1
  def update
    if @video.update(video_params)
      redirect_to @video, notice: "Video was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /videos/1
  def destroy
    @video.destroy
    redirect_to videos_path, notice: "Video was successfully deleted."
  end

  private

  def find_video_or_redirect
    @video = Video.current.find_by(id: params[:id])
    redirect_without_video
  end

  def redirect_without_video
    empty_response_or_root_path(videos_path) unless @video
  end

  def video_params
    params.require(:video).permit(
      :video_page, :vimeo_number, :client_name, :agency_name,
      :photo, :photo_cache, :position, :archived
    )
  end
end
