require 'simplecov'
require 'minitest/pride'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

class ActionController::TestCase
  include Devise::TestHelpers

  def login(resource)
    @request.env["devise.mapping"] = Devise.mappings[resource]
    sign_in(resource.class.name.downcase.to_sym, resource)
  end

  def login_client(resource)
    session[:project_ids] ||= []
    session[:project_ids] << resource.id
  end
end

class ActionDispatch::IntegrationTest
  def sign_in_as(user, password)
    user.update password: password, password_confirmation: password
    post_via_redirect '/login', user: { email: user.email, password: password }
    user
  end

  def sign_in_as_client(project)
    project.update password: project.password_plain, password_confirmation: project.password_plain
    post_via_redirect '/client/login', client: { username: project.username, password: project.password_plain }
  end
end

module Rack
  module Test
    class UploadedFile
      def tempfile
        @tempfile
      end
    end
  end
end
