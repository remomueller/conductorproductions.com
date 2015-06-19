class ClientProjectController < ApplicationController
  before_action :authenticate_client!
  before_action :set_project
  before_action :invert,              only: [ :script, :timeline, :casting ]

  def root
    render 'menu'
  end

  def menu

  end

  private

    def set_project
      @project = current_client
    end

    def invert
      @invert = true
    end

end
