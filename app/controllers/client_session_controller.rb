class ClientSessionController < ApplicationController

  # Show the client login page
  def new
    @invert = true
  end

  # Attempt to login the client
  def create
    project = Project.current.where.not(username: [nil,""]).find_by_username(params[:client][:username])

    if project && project.authenticate(params[:client][:password])
      session[:project_id] = project.id
      redirect_to client_project_menu_path(project)
    else
      render :new
    end
  end

  # Logout the client
  def destroy
    session[:project_id] = nil
    redirect_to client_login_path
  end

end
