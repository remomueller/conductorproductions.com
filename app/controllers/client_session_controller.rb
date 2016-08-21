# frozen_string_literal: true

# Allows clients to login to view project.
class ClientSessionController < ApplicationController
  before_action :invert, only: [:new, :create]

  layout 'application-login', only: [:new, :create]

  # Show the client login page
  def new
  end

  # Attempt to login the client
  def create
    project = Project.current.where.not(username: [nil,""]).find_by_username(params[:client][:username])

    if project && project.authenticate(params[:client][:password])
      session[:project_ids] ||= []
      session[:project_ids] << project.id
      flash[:alert] = nil
      flash[:notice] = nil

      if project.to_param == session[:last_project_param]
        redirect_to (session[:previous_client_url] || client_project_menu_path(project))
      else
        redirect_to client_project_menu_path(project)
      end
    else
      flash[:alert] = 'Invalid username or password.'
      render :new
    end
  end

  # Logout the client
  def destroy
    session[:previous_client_url] = session[:last_project_param] = nil
    session[:project_ids] = nil
    redirect_to client_login_path
  end

  private

  def invert
    @invert = true
  end
end
