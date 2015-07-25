class WelcomeController < ApplicationController

  before_action :authenticate_user!, only: [ :dashboard ]

  layout 'conductor-application-v2'

  def submit_contact
    if params[:name].present? and params[:email].present? and params[:body].present?
      UserMailer.contact(params[:name], params[:email], params[:body]).deliver_later if Rails.env.production?
      redirect_to contact_path, notice: "Thanks for getting in touch!"
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

end
