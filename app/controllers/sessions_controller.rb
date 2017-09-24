# frozen_string_literal: true

# Allows sign in using username or email
class SessionsController < Devise::SessionsController
  before_action :invert, only: [:new, :create]
  prepend_before_action :sign_out_project, only: :destroy

  # layout "application-login", only: [:new, :create]

  # Overwrite devise to provide JSON responses as well
  def create
    project = Project.current.where.not(username: [nil, ""]).find_by_username(params[:user][:email])
    if project && project.authenticate(params[:user][:password])
      session[:project_ids] ||= []
      session[:project_ids] << project.id
      flash[:alert] = nil
      flash[:notice] = nil

      if project.to_param == session[:last_project_param]
        redirect_to (session[:previous_client_url] || client_project_menu_path(project))
      else
        redirect_to client_project_menu_path(project)
      end
    elsif project
      redirect_to new_user_session_path, alert: "Invalid username or password."
    else
      super
    end
  end

  private

  def sign_out_project
    session[:previous_client_url] = session[:last_project_param] = nil
    session[:project_ids] = nil
  end

  def invert
    @invert = true
  end
end
