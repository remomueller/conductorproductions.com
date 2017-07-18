# frozen_string_literal: true

require "test_helper"

# Test director management.
class DirectorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @director = directors(:one)
    @system_admin = users(:system_admin)
  end

  def director_params
    {
      name: @director.name,
      slug: @director.slug,
      biography: @director.biography,
      position: @director.position,
      archived: @director.archived
    }
  end

  test "should get index" do
    login(@system_admin)
    get directors_url
    assert_response :success
  end

  test "should get new" do
    login(@system_admin)
    get new_director_url
    assert_response :success
  end

  test "should create director" do
    login(@system_admin)
    assert_difference("Director.count") do
      post directors_url, params: {
        director: director_params.merge(name: "New Director", slug: "new-director")
      }
    end
    assert_redirected_to director_url(Director.last)
  end

  test "should show director" do
    login(@system_admin)
    get director_url(@director)
    assert_response :success
  end

  test "should get edit" do
    login(@system_admin)
    get edit_director_url(@director)
    assert_response :success
  end

  test "should update director" do
    login(@system_admin)
    patch director_url(@director), params: {
      director: director_params.merge(name: "Update Director", slug: "update-director")
    }
    assert_redirected_to director_url("update-director")
  end

  test "should destroy director" do
    login(@system_admin)
    assert_difference("Director.current.count", -1) do
      delete director_url(@director)
    end
    assert_redirected_to directors_url
  end
end
