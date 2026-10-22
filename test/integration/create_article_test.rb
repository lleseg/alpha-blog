# frozen_string_literal: true

require "test_helper"

class CreateArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "user", email: "user@user.com", password: "password", admin: false)
    sign_in_as(@user)
  end

  test "get new article form and create a article" do
    get "/articles/new"

    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path,
           params: { article: { title: "How to do integration tests",
                                description: "You have to learn how to do integration tests, it's really important!" } }

      assert_response :redirect
    end
    follow_redirect!

    assert_response :success
    assert_match "How to do integration tests", response.body
  end

  test "get new article form and reject an invalid article" do
    get "/articles/new"

    assert_response :success
    assert_no_difference "Article.count" do
      post articles_path,
           params: { article: { title: " ",
                                description: "This is the text of an article that doesn't have a valid title" } }
    end
    assert_match "errors", response.body
    assert_select "div.alert"
    assert_select "p#alert-heading"
  end
end
