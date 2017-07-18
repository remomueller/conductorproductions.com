# frozen_string_literal: true

# Displays public pages.
class ExternalController < ApplicationController
  before_action :set_director, only: [:director, :photo_director]

  # GET /landing/draft
  def landing_draft
    render layout: "conductor-application-v2"
  end

  # GET /director/:slug
  def director
    render layout: "full_page_no_header"
  end

  # GET /director/:slug/photo
  def photo_director
    send_file File.join(CarrierWave::Uploader::Base.root, @director.photo.url)
  end

  private

  def set_director
    @director = Director.current.where(archived: false).find_by_param(params[:director])
    redirect_without_director!
  end

  def redirect_without_director!
    empty_response_or_root_path(directors_path) unless @director
  end
end
