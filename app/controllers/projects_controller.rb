class ProjectsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin #, only: [ :new, :create, :edit, :update, :destroy ]
  before_action :set_project, only: [:show, :agency_logo, :client_logo, :edit, :update, :destroy]

  layout 'application'

  # GET /projects
  # GET /projects.json
  def index
    @projects = Project.current
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
      format.html { redirect_to projects_url, notice: 'Project was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_project
      super(:id)
    end

    def redirect_without_project
      super(projects_path)
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def project_params
      params[:project] ||= { blank: '1' }
      params[:project][:password_plain] = params[:project][:password] unless params[:project][:password].blank?
      params.require(:project).permit(
        :name, :number, :slug,
        :agency_logo, :agency_logo_cache,
        :client_logo, :client_logo_cache,
        :client_name, :username, :password, :password_plain)
    end
end