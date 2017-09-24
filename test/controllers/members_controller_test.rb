# frozen_string_literal: true

require "test_helper"

# Test member management.
class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = members(:one)
    @system_admin = users(:system_admin)
  end

  def member_params
    {
      name: @member.name,
      title: @member.title,
      slug: @member.slug,
      biography: @member.biography,
      position: @member.position,
      archived: @member.archived
    }
  end

  test "should get index" do
    login(@system_admin)
    get members_url
    assert_response :success
  end

  test "should get new" do
    login(@system_admin)
    get new_member_url
    assert_response :success
  end

  test "should create member" do
    login(@system_admin)
    assert_difference("Member.count") do
      post members_url, params: {
        member: member_params.merge(name: "New Member", slug: "new-member")
      }
    end
    assert_redirected_to member_url(Member.last)
  end

  test "should show member" do
    login(@system_admin)
    get member_url(@member)
    assert_response :success
  end

  test "should get edit" do
    login(@system_admin)
    get edit_member_url(@member)
    assert_response :success
  end

  test "should update member" do
    login(@system_admin)
    patch member_url(@member), params: {
      member: member_params.merge(name: "Update Member", slug: "update-member")
    }
    assert_redirected_to member_url("update-member")
  end

  test "should destroy member" do
    login(@system_admin)
    assert_difference("Member.current.count", -1) do
      delete member_url(@member)
    end
    assert_redirected_to members_url
  end
end
