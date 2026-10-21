# frozen_string_literal: true

require "test_helper"

class ListCategoriesTest < ActionDispatch::IntegrationTest
  def setup
    @category_one = Category.create(name: "Sports")
    @category_two = Category.create(name: "Travel")
  end

  test "should show categories listing" do
    get "/categories"
    assert_select "a[href=?]", category_path(@category_one), text: "Sports"
    assert_select "a[href=?]", category_path(@category_two), text: "Travel"
  end
end
