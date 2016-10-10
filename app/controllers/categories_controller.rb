# frozen_string_literal: true

# Allows categories to be created and modified.
class CategoriesController < ApplicationController
  before_action :authenticate_user!

  before_action :set_viewable_project,      only: [:index, :show]
  before_action :set_editable_project,      only: [:new, :create, :edit, :update, :destroy]
  before_action :redirect_without_project

  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories
  def index
    @categories = @project.categories
  end

  # GET /categories/1
  def show
  end

  # GET /categories/new
  def new
    @category = @project.categories.new(position: @project.categories.count+1)
  end

  # GET /categories/1/edit
  def edit
  end

  # POST /categories
  def create
    @category = current_user.categories.where(project_id: @project.id).new(category_params)
    if @category.save
      redirect_to [@project, @category], notice: 'Category was successfully created.'
    else
      render :new
    end
  end

  # PATCH /categories/1
  def update
    if @category.update(category_params)
      redirect_to [@project, @category], notice: 'Category was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /categories/1
  def destroy
    @category.destroy
    redirect_to project_categories_path(@project), notice: 'Category was successfully deleted.'
  end

  private

  def set_category
    @category = @project.categories.find_by_param(params[:id])
  end

  def category_params
    params.require(:category).permit(:top_level, :name, :slug, :position)
  end
end
