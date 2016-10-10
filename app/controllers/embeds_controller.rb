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
  def index
    @embeds = @project.embeds
  end

  # GET /embeds/1
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
  def create
    @embed = current_user.embeds.where(project_id: @project.id).new(embed_params)
    if @embed.save
      redirect_to [@project, @embed], notice: 'Embed was successfully created.'
    else
      render :new
    end
  end

  # PATCH /embeds/1
  # PATCH /embeds/1.js
  def update
    if @embed.update(embed_params)
      respond_to do |format|
        format.html { redirect_to [@project, @embed], notice: 'Embed was successfully updated.' }
        format.js
      end
    else
      render :edit
    end
  end

  # DELETE /embeds/1
  def destroy
    @embed.destroy
    redirect_to project_embeds_path(@project), notice: 'Embed was successfully deleted.'
  end

  private

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
