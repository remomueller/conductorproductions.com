# frozen_string_literal: true

require "test_helper"

# Tests to assure external pages are accessible.
class ExternalControllerTest < ActionDispatch::IntegrationTest
  test "should get member page" do
    get public_member_url(members(:one))
    assert_response :success
  end

  test "should get landing" do
    get landing_url
    assert_response :success
  end

  test "should get services" do
    get services_url
    assert_response :success
  end

  test "should get contact" do
    get contact_url
    assert_response :success
  end

  test "should get version" do
    get version_url
    assert_response :success
  end

  test "should get version as json" do
    get version_url(format: "json")
    version = JSON.parse(response.body)
    assert_equal WwwConductorproductionsCom::VERSION::STRING, version["version"]["string"]
    assert_equal WwwConductorproductionsCom::VERSION::MAJOR, version["version"]["major"]
    assert_equal WwwConductorproductionsCom::VERSION::MINOR, version["version"]["minor"]
    assert_equal WwwConductorproductionsCom::VERSION::TINY, version["version"]["tiny"]
    if WwwConductorproductionsCom::VERSION::BUILD.nil?
      assert_nil version["version"]["build"]
    else
      assert_equal WwwConductorproductionsCom::VERSION::BUILD, version["version"]["build"]
    end
    assert_response :success
  end
end
