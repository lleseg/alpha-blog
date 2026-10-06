# frozen_string_literal: true

require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = Article.create(title: "This is an awesome title!",
                              description: "This is also awesome, but it is a description!")
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should create article with correct params" do
    assert_difference("Article.count") do
      post articles_url,
           params: { article: { title: "Wow, a new title!",
                                description: "How cool, a new description as well!" } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should not create article with incorrect title" do
    assert_no_difference("Article.count") do
      post articles_url,
           params: { article: { title: "Not!",
                                description: "How cool, a new description as well!" } }
    end

    assert_response :unprocessable_entity
  end

  test "should not create article with incorrect description" do
    assert_no_difference("Article.count") do
      post articles_url,
           params: { article: { title: "Wow, a new title!",
                                description: "Not!" } }
    end

    assert_response :unprocessable_entity
  end

  test "should update article with correct params" do
    patch article_url(@article), params: { article: { title: "I was updated!" } }
    assert_redirected_to article_url(@article)
    assert_equal "I was updated!", @article.reload.title
  end

  test "should not update article with incorrect title" do
    patch article_url(@article), params: { article: { title: "Not!" } }
    assert_response :unprocessable_entity
    assert_equal "This is an awesome title!", @article.reload.title
  end

  test "should not update article with incorrect description" do
    patch article_url(@article), params: { article: { description: "Not!" } }
    assert_response :unprocessable_entity
    assert_equal "This is also awesome, but it is a description!", @article.reload.description
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_path
  end
end
