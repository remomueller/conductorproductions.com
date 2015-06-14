class WelcomeController < ApplicationController

  before_action :authenticate_user!, only: [ :dashboard ]

  layout 'conductor-application-v2'

  def index
    # render layout: 'conductor-application-v2'
  end

  def work
    # render layout: 'conductor-application-v2'
  end

  def contact
    # render layout: 'conductor-application-v2'
  end

  def index_v1
    render layout: 'conductor-application-v1'
  end

  def dashboard
    render layout: 'application'
  end

end
