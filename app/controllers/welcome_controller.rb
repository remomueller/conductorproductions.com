class WelcomeController < ApplicationController

  before_action :authenticate_user!, only: [ :dashboard ]

  layout 'conductor-application-v2'

  def index
    # render layout: 'conductor-application-v2'
  end

  def work
    # render layout: 'conductor-application-v2'
  end

  def contact
    # render layout: 'conductor-application-v2'
  end

  def submit_contact
    if params[:name].present? and params[:email].present? and params[:body].present?
      UserMailer.contact(params[:name], params[:email], params[:body]).deliver_later if Rails.env.production?
      redirect_to contact_path, notice: "Thanks for getting in touch!"
    else
      render 'contact'
    end
  end

  def index_v1
    render layout: 'conductor-application-v1'
  end

  def dashboard
    render layout: 'application'
  end

end
