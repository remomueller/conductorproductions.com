# frozen_string_literal: true

# Allows users to be managed.
class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin
  before_action :set_user,              only: [:show, :edit, :update, :destroy]
  before_action :redirect_without_user, only: [:show, :edit, :update, :destroy]

  layout 'application'

  # GET /users
  def index
    @users = User.current
  end

  # GET /users/1
  def show
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_path, notice: 'User was successfully deleted.'
  end

  private

  def set_user
    @user = User.current.find_by_id(params[:id])
  end

  def redirect_without_user
    empty_response_or_root_path(users_path) unless @user
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :system_admin)
  end
end
