# frozen_string_literal: true

# Allows categories to be created and modified.
class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_viewable_project_or_redirect, only: [:index, :show]
  before_action :find_editable_project_or_redirect, only: [:new, :create, :edit, :update, :destroy, :save_gallery_order]
  before_action :find_category_or_redirect, only: [:show, :edit, :update, :destroy, :save_gallery_order]

  # POST /categories/1/save_gallery_order.js
  def save_gallery_order
    params[:gallery_ids].each_with_index do |gallery_id, index|
      gallery = @category.galleries.find_by_id gallery_id
      gallery.update position: index if gallery
    end
    head :ok
  end

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

  def find_category_or_redirect
    @category = @project.categories.find_by_param params[:id]
    redirect_without_category
  end

  def redirect_without_category
    empty_response_or_root_path(project_categories_path(@project)) unless @category
  end

  def category_params
    params.require(:category).permit(:top_level, :name, :slug, :position)
  end
end
