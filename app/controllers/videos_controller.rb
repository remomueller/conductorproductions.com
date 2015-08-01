class VideosController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin
  before_action :set_video,               only: [:show, :edit, :update, :destroy]
  before_action :redirect_without_video,  only: [:show, :edit, :update, :destroy]

  # GET /videos
  # GET /videos.json
  def index
    @videos = Video.current.order(:archived, :page, :position)
  end

  # GET /videos/1
  # GET /videos/1.json
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
  # POST /videos.json
  def create
    @video = current_user.videos.new(video_params)

    respond_to do |format|
      if @video.save
        format.html { redirect_to @video, notice: 'Video was successfully created.' }
        format.json { render :show, status: :created, location: @video }
      else
        format.html { render :new }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /videos/1
  # PATCH/PUT /videos/1.json
  def update
    respond_to do |format|
      if @video.update(video_params)
        format.html { redirect_to @video, notice: 'Video was successfully updated.' }
        format.json { render :show, status: :ok, location: @video }
      else
        format.html { render :edit }
        format.json { render json: @video.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /videos/1
  # DELETE /videos/1.json
  def destroy
    @video.destroy
    respond_to do |format|
      format.html { redirect_to videos_path, notice: 'Video was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_video
      @video = Video.current.find_by_id(params[:id])
    end

    def redirect_without_video
      empty_response_or_root_path(videos_path) unless @video
    end

    def video_params
      params.require(:video).permit(:page, :vimeo_number, :photo, :photo_cache, :position, :archived)
    end
end
