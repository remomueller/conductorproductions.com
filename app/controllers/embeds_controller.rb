# frozen_string_literal: true

# Allows embeds to be added to categories.
class EmbedsController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_without_project

  before_action :set_embed, only: [:show, :edit, :update, :destroy]
  before_action :redirect_without_embed, only: [:show, :edit, :update, :destroy]

  # GET /embeds
  # GET /embeds.json
  def index
    @embeds = @project.embeds
  end

  # GET /embeds/1
  # GET /embeds/1.json
  def show
  end

  # GET /embeds/new
  def new
    @embed = @project.embeds.new
  end

  # GET /embeds/1/edit
  def edit
  end

  # POST /embeds
  # POST /embeds.json
  def create
    @embed = current_user.embeds.where(project_id: @project.id).new(embed_params)

    respond_to do |format|
      if @embed.save
        format.html { redirect_to [@project, @embed], notice: 'Embed was successfully created.' }
        format.json { render :show, status: :created, location: @embed }
      else
        format.html { render :new }
        format.json { render json: @embed.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /embeds/1
  # PATCH/PUT /embeds/1.json
  def update
    respond_to do |format|
      if @embed.update(embed_params)
        format.html { redirect_to [@project, @embed], notice: 'Embed was successfully updated.' }
        format.json { render :show, status: :ok, location: @embed }
      else
        format.html { render :edit }
        format.json { render json: @embed.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /embeds/1
  # DELETE /embeds/1.json
  def destroy
    @embed.destroy
    respond_to do |format|
      format.html { redirect_to project_embeds_path(@project), notice: 'Embed was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_embed
      @embed = @project.embeds.find_by_id(params[:id])
    end

    def redirect_without_embed
      empty_response_or_root_path(project_embeds_path(@project)) unless @embed
    end

    def embed_params
      params.require(:embed).permit(:category_id, :embed_url, :archived)
    end
end
