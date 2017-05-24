# frozen_string_literal: true

require "test_helper"

# Tests to assure external pages are accessible.
class ExternalControllerTest < ActionDispatch::IntegrationTest
  test "should get landing draft" do
    get landing_draft_path
    assert_response :success
  end
end
