class LocationsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_without_project

  before_action :set_location,              only: [:show, :edit, :update, :destroy]
  before_action :redirect_without_location, only: [:show, :edit, :update, :destroy]

  # GET /locations
  # GET /locations.json
  def index
    @locations = @project.locations
  end

  # GET /locations/1
  # GET /locations/1.json
  def show
  end

  # GET /locations/new
  def new
    @location = @project.locations.new
  end

  # GET /locations/1/edit
  def edit
  end

  # POST /locations
  # POST /locations.json
  def create
    @location = current_user.locations.where(project_id: @project.id).new(location_params)

    respond_to do |format|
      if @location.save
        format.html { redirect_to [@project, @location], notice: 'Location was successfully created.' }
        format.json { render :show, status: :created, location: @location }
      else
        format.html { render :new }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /locations/1
  # PATCH/PUT /locations/1.json
  def update
    respond_to do |format|
      if @location.update(location_params)
        format.html { redirect_to [@project, @location], notice: 'Location was successfully updated.' }
        format.json { render :show, status: :ok, location: @location }
      else
        format.html { render :edit }
        format.json { render json: @location.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /locations/1
  # DELETE /locations/1.json
  def destroy
    @location.destroy
    respond_to do |format|
      format.html { redirect_to project_locations_path(@project), notice: 'Location was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_location
      @location = @project.locations.find_by_id(params[:id])
    end

    def redirect_without_location
      empty_response_or_root_path(project_locations_path(@project)) unless @location
    end

    def location_params
      params.require(:location).permit(:category_id, :name, :address, :archived)
    end
end
