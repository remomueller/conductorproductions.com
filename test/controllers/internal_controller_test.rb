# frozen_string_literal: true

require "test_helper"

# Test that admins and collaborators can visit administrative pages.
class InternalControllerTest < ActionDispatch::IntegrationTest
  setup do
    @client = projects(:one)
    @system_admin = users(:system_admin)
    @collaborator = users(:collaborator)
  end

  test "should get dashboard as collaborator" do
    login(@collaborator)
    get dashboard_url
    assert_redirected_to projects_path
  end

  test "should get dashboard as system admin" do
    login(@system_admin)
    get dashboard_url
    assert_redirected_to projects_path
  end
end
