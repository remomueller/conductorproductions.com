# frozen_string_literal: true

# Main web application controller for website.
class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  skip_before_action :verify_authenticity_token, if: :devise_login?
  before_action :configure_permitted_parameters, if: :devise_controller?

  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.

  def after_sign_in_path_for(resource)
    session[:previous_url] || dashboard_path
  end

  protected

  def devise_login?
    params[:controller] == 'devise/sessions' && params[:action] == 'create'
  end

  def configure_permitted_parameters
    keys = [:first_name, :last_name, :email, :password, :password_confirmation]
    devise_parameter_sanitizer.permit(:sign_up, keys: keys)
  end

  def check_system_admin
    return if current_user.system_admin?
    redirect_to root_path, alert: 'You do not have sufficient privileges to access that page.'
  end

  def project_ids
    @project_ids
  end

  def client_projects
    @client_projects ||= begin
      Project.current.where(id: session[:project_ids])
    end
  end
  helper_method :client_projects

  def current_client?
    client_projects.count > 0
  end
  helper_method :current_client?

  # def authenticate_client!
  #   redirect_to client_login_path unless current_client
  # end

  def authenticate_client_or_current_user!
    redirect_to client_login_path unless current_client? || current_user
  end

  def set_editable_project(id = :project_id)
    @project = current_user.all_projects.find_by_param(params[id])
  end

  def set_viewable_project(id = :project_id)
    @project = current_user.all_viewable_projects.find_by_param(params[id])
  end

  def redirect_without_project(path = root_path)
    empty_response_or_root_path(path) unless @project
  end

  def empty_response_or_root_path(path = root_path)
    respond_to do |format|
      format.html { redirect_to path }
      format.js { head :ok }
      format.json { head :no_content }
    end
  end

  def store_location_in_session
    if !request.post? and !request.xhr?
      session[:previous_client_url] = request.fullpath
      session[:last_project_param] = params[:id]
    end
  end
end
