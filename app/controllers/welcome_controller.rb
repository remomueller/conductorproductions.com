class WelcomeController < ApplicationController

  before_action :authenticate_user!, only: [ :dashboard ]

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

  end

end
