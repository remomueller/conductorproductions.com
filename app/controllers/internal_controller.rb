# frozen_string_literal: true

# Displays internal administrative pages.
class InternalController < ApplicationController
  before_action :authenticate_user!
  before_action :check_for_project_invite, only: :dashboard

  # # GET /dashboard
  # def dashboard
  # end

  private

  def check_for_project_invite
    if session[:invite_token].present?
      redirect_to accept_project_users_path
    else
      redirect_to projects_path
    end
  end
end
