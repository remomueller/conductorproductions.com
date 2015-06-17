class ClientProjectController < ApplicationController

  before_action :authenticate_client!

  before_action :set_project

  def root
    render 'menu'
  end

  def menu

  end

  private

    def set_project
      @project = current_client
    end

end
