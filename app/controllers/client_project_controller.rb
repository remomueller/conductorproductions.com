# frozen_string_literal: true

# Allows clients to browse project.
class ClientProjectController < ApplicationController
  before_action :store_location_in_session, except: [ :download_document, :download_location_photo, :agency_logo, :client_logo ]
  before_action :authenticate_client_or_current_user!
  before_action :set_project
  before_action :set_project_for_current_user
  before_action :redirect_without_project
  before_action :invert,              only: [ :category, :document, :location_show, :location_photo ]

  layout 'application-sidebar', only: [ :category, :document, :location_show, :location_photo ]

  def root
    render 'menu'
  end

  def menu
  end

  def category
    @category = @project.categories.find_by_param(params[:category_id])
    if @category
      @document = @category.documents.where(archived: false).first
      @embed = @category.embeds.where(archived: false).first
      @locations = @category.locations.where(archived: false)
    else
      redirect_to client_project_root_path(@project)
    end
  end

  def document
    @category = @project.categories.find_by_param(params[:category_id])
    if @category
      @document = @project.documents.find_by_id(params[:document_id])
      render 'category'
    else
      redirect_to client_project_root_path(@project)
    end
  end

  def download_document
    @document = @project.documents.find_by_id(params[:document_id])
    if @document and @document.document.size > 0
      disposition = (params[:inline] == '1' ? 'inline' : 'attachment')
      type = (@document.pdf? ? 'application/pdf' : (@document.image? ? 'image/png' : 'application/octet-stream' ))
      send_file File.join( CarrierWave::Uploader::Base.root, @document.document.url ), type: type, disposition: disposition
    else
      head :ok
    end
  end

  def location_show
    @location = @project.locations.find_by_param(params[:location_id])
    if @location
      # render 'location'
    else
      redirect_to client_project_root_path(@project)
    end
  end

  def location_photo
    @location_photo = @project.location_photos.find_by_id(params[:location_photo_id])
    if @location_photo
      # render 'location_photo'
    else
      redirect_to client_project_root_path(@project)
    end
  end

  def download_location_photo
    @location_photo = @project.location_photos.find_by_id(params[:location_photo_id])
    if @location_photo and @location_photo.photo.size > 0
      if params[:size] == 'preview'
        send_file File.join( CarrierWave::Uploader::Base.root, @location_photo.photo.preview.url )
      elsif params[:size] == 'thumb'
        send_file File.join( CarrierWave::Uploader::Base.root, @location_photo.photo.thumb.url )
      else
        send_file File.join( CarrierWave::Uploader::Base.root, @location_photo.photo.url )
      end
    else
      head :ok
    end
  end

  def agency_logo
    send_file File.join( CarrierWave::Uploader::Base.root, @project.agency_logo.url )
  end

  def client_logo
    send_file File.join( CarrierWave::Uploader::Base.root, @project.client_logo.url )
  end

  private

    def set_project
      @project = Project.current.where(id: session[:project_ids]).find_by_param(params[:id])
    end

    def set_project_for_current_user
      unless @project
        @project = current_user.all_viewable_projects.find_by_param(params[:id]) if current_user
      end
    end

    def redirect_without_project
      empty_response_or_root_path(client_login_path) unless @project
    end

    def invert
      @invert = true
    end
end
