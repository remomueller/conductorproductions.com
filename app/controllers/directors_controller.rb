# frozen_string_literal: true

# Allow admins to modify directors.
class DirectorsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin
  before_action :set_director, only: [:show, :edit, :update, :destroy]

  # GET /directors
  def index
    @directors = Director.current.order("position nulls last").page(params[:page]).per(20)
  end

  # # GET /directors/1
  # def show
  # end

  # GET /directors/new
  def new
    @director = Director.new
  end

  # # GET /directors/1/edit
  # def edit
  # end

  # POST /directors
  def create
    @director = Director.new(director_params)
    if @director.save
      redirect_to @director, notice: "Director was successfully created."
    else
      render :new
    end
  end

  # PATCH /directors/1
  def update
    if @director.update(director_params)
      redirect_to @director, notice: "Director was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /directors/1
  def destroy
    @director.destroy
    respond_to do |format|
      format.html { redirect_to directors_path, notice: "Director was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_director
    @director = Director.find_by_param(params[:id])
    redirect_without_director!
  end

  def redirect_without_director!
    empty_response_or_root_path(directors_path) unless @director
  end

  def director_params
    params.require(:director).permit(
      :name, :slug, :biography, :photo, :photo_cache, :position, :archived
    )
  end
end
