class ClientProjectController < ApplicationController
  before_action :authenticate_client!
  before_action :set_project
  before_action :invert,              only: [ :category, :document ]

  layout 'application-sidebar', only: [ :category, :document ]

  def root
    render 'menu'
  end

  def menu
  end

  def category
    @category = @project.categories.find_by_param(params[:category_id])
    if @category
      @document = @category.documents.where(archived: false).first
      @embed = @category.embeds.where(archived: false).first
    else
      redirect_to client_project_root_path(@project)
    end
  end

  def document
    @category = @project.categories.find_by_param(params[:category_id])
    if @category
      @document = @project.documents.find_by_id(params[:document_id])
      render 'category'
    else
      redirect_to client_project_root_path(@project)
    end
  end

  def download_document
    @document = @project.documents.find_by_id(params[:document_id])
    if @document and @document.document.size > 0
      disposition = (params[:inline] == '1' ? 'inline' : 'attachment')
      type = (@document.pdf? ? 'application/pdf' : (@document.image? ? 'image/png' : 'application/octet-stream' ))
      send_file File.join( CarrierWave::Uploader::Base.root, @document.document.url ), type: type, disposition: disposition
    else
      head :ok
    end
  end

  def agency_logo
    send_file File.join( CarrierWave::Uploader::Base.root, @project.agency_logo.url )
  end

  def client_logo
    send_file File.join( CarrierWave::Uploader::Base.root, @project.client_logo.url )
  end

  private

    def set_project
      @project = current_client
    end

    def invert
      @invert = true
    end

end
