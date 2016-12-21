# frozen_string_literal: true

require 'test_helper'

# Tests to assure that version can be viewed.
class ApplicationControllerTest < ActionController::TestCase
  test 'should get version' do
    get :version
    assert_response :success
  end

  test 'should get version as json' do
    get :version, format: 'json'
    version = JSON.parse(response.body)
    assert_equal WwwConductorproductionsCom::VERSION::STRING, version['version']['string']
    assert_equal WwwConductorproductionsCom::VERSION::MAJOR, version['version']['major']
    assert_equal WwwConductorproductionsCom::VERSION::MINOR, version['version']['minor']
    assert_equal WwwConductorproductionsCom::VERSION::TINY, version['version']['tiny']
    if WwwConductorproductionsCom::VERSION::BUILD.nil?
      assert_nil version['version']['build']
    else
      assert_equal WwwConductorproductionsCom::VERSION::BUILD, version['version']['build']
    end
    assert_response :success
  end
end
