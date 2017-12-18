# frozen_string_literal: true

# Allows projects to be created and updated.
class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin, only: [:new, :create]
  before_action :find_deletable_project_or_redirect, only: [:destroy]
  before_action :find_editable_project_or_redirect, only: [
    :invite_user, :edit, :update, :save_category_order
  ]
  before_action :find_viewable_project_or_redirect, only: [
    :collaborators, :show, :agency_logo, :client_logo
  ]

  layout "layouts/full_page_sidebar2"

  # POST /projects/1/save_category_order.js
  def save_category_order
    params[:category_ids].each_with_index do |category_id, index|
      category = @project.categories.where(top_level: params[:top_level]).find_by_id category_id
      category.update position: index if category
    end
    head :ok
  end

  def collaborators
  end

  def invite_user
    create_member_invite
    render 'projects/collaborators'
  end

  # GET /projects
  def index
    @projects = current_user.all_viewable_projects.where(archived: false).page(params[:page]).per(20)
  end

  def archived
    @projects = current_user.all_viewable_projects.where(archived: true).page(params[:page]).per(20)
  end

  # GET /projects/1
  def show
  end

  def agency_logo
    send_file File.join(CarrierWave::Uploader::Base.root, @project.agency_logo.url)
  end

  def client_logo
    send_file File.join(CarrierWave::Uploader::Base.root, @project.client_logo.url)
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  def create
    @project = current_user.projects.new(project_params)
    if @project.save
      redirect_to @project, notice: 'Project was successfully created.'
    else
      render :new
    end
  end

  # PATCH /projects/1
  def update
    if @project.update(project_params)
      redirect_to @project, notice: 'Project was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
    redirect_to projects_path, notice: 'Project was successfully deleted.'
  end

  private

  def find_editable_project_or_redirect
    super(:id)
  end

  def find_viewable_project_or_redirect
    super(:id)
  end

  def find_deletable_project_or_redirect
    @project = Project.where(user_id: current_user.id).find_by_param(params[:id])
    redirect_without_project
  end

  def redirect_without_project
    super(projects_path)
  end

  def project_params
    params[:project] ||= { blank: '1' }
    params[:project][:password_plain] = params[:project][:password] unless params[:project][:password].blank?
    params.require(:project).permit(
      :name, :number, :slug,
      :agency_logo, :agency_logo_cache,
      :client_logo, :client_logo_cache,
      :client_name, :username, :password, :password_plain,
      :archived)
  end

  def editor?
    (params[:editor] == '1')
  end

  def member_scope
    @project.project_users
  end

  def invite_email
    params[:invite_email].to_s.strip
  end

  def associated_user
    current_user.associated_users.find_by_email(invite_email.split('[').last.to_s.split(']').first)
  end

  def create_member_invite
    if associated_user
      add_existing_member(associated_user)
    elsif invite_email.present?
      invite_new_member
    end
  end

  def add_existing_member(user)
    @member = member_scope.where(user_id: user.id).first_or_create(creator_id: current_user.id)
    @member.update editor: editor?
    @member.send_user_added_email_in_background!
  end

  def invite_new_member
    @member = member_scope.where(invite_email: invite_email).first_or_create(creator_id: current_user.id)
    @member.update editor: editor?
    @member.send_user_invited_email_in_background!
  end
end
