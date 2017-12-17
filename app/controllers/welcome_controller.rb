# frozen_string_literal: true

# Displays public facing pages.
class WelcomeController < ApplicationController
  layout "conductor-application-v2"

  def submit_contact
    if params[:name].present? && params[:email].present? && params[:body].present?
      UserMailer.contact(params[:name], params[:email], params[:body]).deliver_now if EMAILS_ENABLED
      redirect_to contact_path, notice: "Thanks for getting in touch!"
    else
      render :contact
    end
  end

  # def index_v1
  #   render layout: "conductor-application-v1"
  # end

  # GET /drtv
  def drtv
    redirect_to work_path
  end
end
