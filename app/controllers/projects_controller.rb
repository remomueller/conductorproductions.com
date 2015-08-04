class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin,        only: [:new, :create]
  before_action :set_deletable_project,     only: [:destroy]
  before_action :set_editable_project,      only: [:invite_user, :edit, :update]
  before_action :set_viewable_project,      only: [:collaborators, :show, :agency_logo, :client_logo]
  before_action :redirect_without_project,  only: [:collaborators, :invite_user, :show, :agency_logo, :client_logo, :edit, :update, :destroy]

  layout 'application'

  def collaborators
  end

  def invite_user
    invite_email = params[:invite_email].to_s.strip
    @user = current_user.associated_users.find_by_email(invite_email.split('[').last.to_s.split(']').first)

    member_scope = @project.project_users

    if @user
      @member = member_scope.where(user_id: @user.id).first_or_create( creator_id: current_user.id )
      @member.update( editor: (params[:editor] == '1') )
    elsif not invite_email.blank?
      @member = member_scope.where(invite_email: invite_email).first_or_create( creator_id: current_user.id )
      @member.update( editor: (params[:editor] == '1') )
      @member.generate_invite_token!
    end

    render 'projects/collaborators'
  end

  # GET /projects
  # GET /projects.json
  def index
    @projects = current_user.all_viewable_projects.where(archived: false).page(params[:page]).per( 20 )
  end

  def archived
    @projects = current_user.all_viewable_projects.where(archived: true).page(params[:page]).per( 20 )
  end

  # GET /projects/1
  # GET /projects/1.json
  def show
  end

  def agency_logo
    send_file File.join( CarrierWave::Uploader::Base.root, @project.agency_logo.url )
  end

  def client_logo
    send_file File.join( CarrierWave::Uploader::Base.root, @project.client_logo.url )
  end

  # GET /projects/new
  def new
    @project = Project.new
  end

  # GET /projects/1/edit
  def edit
  end

  # POST /projects
  # POST /projects.json
  def create
    @project = current_user.projects.new(project_params)

    respond_to do |format|
      if @project.save
        format.html { redirect_to @project, notice: 'Project was successfully created.' }
        format.json { render :show, status: :created, location: @project }
      else
        format.html { render :new }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /projects/1
  # PATCH/PUT /projects/1.json
  def update
    respond_to do |format|
      if @project.update(project_params)
        format.html { redirect_to @project, notice: 'Project was successfully updated.' }
        format.json { render :show, status: :ok, location: @project }
      else
        format.html { render :edit }
        format.json { render json: @project.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.json
  def destroy
    @project.destroy
    respond_to do |format|
      format.html { redirect_to projects_path, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_editable_project
      super(:id)
    end

    def set_viewable_project
      super(:id)
    end

    def set_deletable_project
      @project = Project.where(user_id: current_user.id).find_by_param(params[:id])
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
end
