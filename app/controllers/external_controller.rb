# frozen_string_literal: true

# Displays public pages.
class ExternalController < ApplicationController
  before_action :set_member, only: [:member, :member2, :photo_member]

  # GET /art
  def art
    render layout: "layouts/full_page_custom_header"
  end

  # GET /landing
  def landing
    render layout: "layouts/full_page_no_header"
  end

  # GET /landing/:page
  def landing_page
    page = params[:page].to_i
    page = nil if page <= 1
    render "landing#{page}", layout: "layouts/full_page_no_header"
  end

  # GET /creators
  def creators
    render :team, layout: "layouts/full_page_custom_header"
  end

  # GET /services
  def services
    render layout: "layouts/full_page_custom_header"
  end

  # GET /team
  def team
    render layout: "layouts/full_page_custom_header"
  end

  # GET /work
  def work
    render layout: "layouts/full_page_custom_header"
  end

  # GET /contact
  def contact
    render layout: "layouts/full_page_custom_header"
  end

  # POST /contact
  def submit_contact
    if params[:name].present? && params[:email].present? && params[:body].present?
      UserMailer.contact(params[:name], params[:email], params[:body]).deliver_now if EMAILS_ENABLED
      redirect_to contact_path, notice: "Thanks for getting in touch!"
    else
      render :contact, layout: "layouts/full_page_custom_header"
    end
  end

  # GET /version
  # GET /version.json
  def version
    render layout: "layouts/full_page_no_header_no_footer"
  end

  # GET /team/:slug
  def member
    render layout: "layouts/full_page_no_header_no_footer"
  end

  # GET /team/:slug/member2
  def member2
    render layout: "layouts/full_page_no_header_no_footer"
  end

  # GET /team/:slug/photo
  def photo_member
    send_file File.join(CarrierWave::Uploader::Base.root, @member.photo.url)
  end

  # GET /images/videos/:video_id
  def download_video_image
    @video = Video.current.find_by(id: params[:video_id])
    if @video && @video.photo.size > 0
      if params[:size] == "preview"
        send_file File.join(CarrierWave::Uploader::Base.root, @video.photo.preview.url)
      elsif params[:size] == "thumb"
        send_file File.join(CarrierWave::Uploader::Base.root, @video.photo.thumb.url)
      else
        send_file File.join(CarrierWave::Uploader::Base.root, @video.photo.url)
      end
    else
      head :ok
    end
  end

  # GET /year-in-review
  def year_in_review
    render "welcome/years/year_2017", layout: "layouts/full_page_no_header_no_footer"
  end

  # GET /2017
  def year_2017
    render "welcome/years/year_2017", layout: "layouts/full_page_no_header_no_footer"
  end

  # GET /2016
  def year_2016
    render "welcome/years/year_2016", layout: "layouts/full_page_no_header_no_footer"
  end

  private

  def set_member
    @member = Member.current.where(archived: false).find_by_param(params[:member])
    redirect_without_member!
  end

  def redirect_without_member!
    empty_response_or_root_path(members_path) unless @member
  end
end
