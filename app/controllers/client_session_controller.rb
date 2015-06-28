class ClientSessionController < ApplicationController

  before_action :invert,              only: [ :new, :create ]

  layout 'application-login', only: [ :new, :create ]

  # Show the client login page
  def new
    redirect_to client_project_root_path(current_client) if current_client
  end

  # Attempt to login the client
  def create
    project = Project.current.where.not(username: [nil,""]).find_by_username(params[:client][:username])

    if project && project.authenticate(params[:client][:password])
      session[:project_id] = project.id
      flash[:alert] = nil
      flash[:notice] = nil
      redirect_to client_project_menu_path(project)
    else
      flash[:alert] = 'Invalid username or password.'
      render :new
    end
  end

  # Logout the client
  def destroy
    session[:project_id] = nil
    redirect_to client_login_path
  end

  private

    def invert
      @invert = true
    end

end
