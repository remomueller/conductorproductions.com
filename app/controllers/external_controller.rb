# frozen_string_literal: true

# Displays public pages.
class ExternalController < ApplicationController
  # GET /landing/draft
  def landing_draft
    render layout: "conductor-application-v2"
  end
end
