# frozen_string_literal: true

# Displays public facing pages.
class WelcomeController < ApplicationController
  before_action :authenticate_user!, only: [ :dashboard ]

  layout 'conductor-application-v2'

  def submit_contact
    if params[:name].present? && params[:email].present? && params[:body].present?
      UserMailer.contact(params[:name], params[:email], params[:body]).deliver_now if EMAILS_ENABLED
      redirect_to contact_path, notice: 'Thanks for getting in touch!'
    else
      render 'contact'
    end
  end

  # def index_v1
  #   render layout: 'conductor-application-v1'
  # end

  def dashboard
    if session[:invite_token].present?
      redirect_to accept_project_users_path
    else
      render layout: 'application'
    end
  end

  def download_video_image
    @video = Video.current.find_by_id(params[:video_id])
    if @video && @video.photo.size > 0
      if params[:size] == 'preview'
        send_file File.join(CarrierWave::Uploader::Base.root, @video.photo.preview.url)
      elsif params[:size] == 'thumb'
        send_file File.join(CarrierWave::Uploader::Base.root, @video.photo.thumb.url)
      else
        send_file File.join(CarrierWave::Uploader::Base.root, @video.photo.url)
      end
    else
      head :ok
    end
  end
end
