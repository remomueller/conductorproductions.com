# frozen_string_literal: true

# Allow admins to modify members.
class MembersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_system_admin
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  def index
    @members = Member.current.order(Arel.sql("position nulls last")).page(params[:page]).per(20)
  end

  # # GET /members/1
  # def show
  # end

  # GET /members/new
  def new
    @member = Member.new
  end

  # # GET /members/1/edit
  # def edit
  # end

  # POST /members
  def create
    @member = Member.new(member_params)
    if @member.save
      redirect_to @member, notice: "Member was successfully created."
    else
      render :new
    end
  end

  # PATCH /members/1
  def update
    if @member.update(member_params)
      redirect_to @member, notice: "Member was successfully updated."
    else
      render :edit
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_path, notice: "Member was successfully deleted." }
      format.json { head :no_content }
    end
  end

  private

  def set_member
    @member = Member.find_by_param(params[:id])
    redirect_without_member!
  end

  def redirect_without_member!
    empty_response_or_root_path(members_path) unless @member
  end

  def member_params
    params.require(:member).permit(
      :name, :slug, :title, :nickname, :biography, :photo, :photo_cache,
      :position, :archived
    )
  end
end
