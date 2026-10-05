# frozen_string_literal: true

require 'test_helper'

class ArticleTest < ActiveSupport::TestCase
  test 'should save an article with required params' do
    article = Article.new(title: 'Test article', description: 'This is a test article for Rails!')

    assert article.save
  end

  test 'should not save an article if without required params' do
    article = Article.new

    assert_not article.save
  end

  test 'should not save an article if title is shorter than 6 chars' do
    article = Article.new(title: 'Test', description: 'This is a test article for Rails!')

    assert_not article.save
  end

  test 'should not save an article if title is longer than 100 chars' do
    article = Article.new(
      title: 'Test' * 26, description: 'This is a test article for Rails!'
    )

    assert_not article.save
  end

  test 'should not save an article if description is shorter than 10 chars' do
    article = Article.new(
      title: 'Test article', description: 'This!'
    )

    assert_not article.save
  end

  test 'should not save an article if description is longer than 300 chars' do
    article = Article.new(
      title: 'Test article', description: 'This is a test article for Rails!' * 10
    )

    assert_not article.save
  end
end
