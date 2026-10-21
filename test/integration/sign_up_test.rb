# frozen_string_literal: true

require "test_helper"

class CreateCategoryTest < ActionDispatch::IntegrationTest
  test "get sign up form and create a user" do
    get "/signup"

    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "conan", email: "conan@example.com", password: "password" } }

      assert_response :redirect
    end
    follow_redirect!

    assert_response :success
    assert_match "conan", response.body
  end

  test "get sign up form and reject an invalid user" do
    get "/signup"

    assert_response :success
    assert_no_difference "User.count" do
      post users_path, params: { user: { username: "co", email: "conan@example.com", password: "password" } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "p#alert-heading"
  end
end
