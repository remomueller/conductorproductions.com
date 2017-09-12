# frozen_string_literal: true

# Displays public pages.
class ExternalController < ApplicationController
  before_action :set_member, only: [:member, :photo_member]

  # GET /landing/draft
  def landing_draft
    render layout: "conductor-application-v2"
  end

  # GET /team/:slug
  def member
    render layout: "full_page_no_header"
  end

  # GET /team/:slug/photo
  def photo_member
    send_file File.join(CarrierWave::Uploader::Base.root, @member.photo.url)
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
