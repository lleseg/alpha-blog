# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  test "category should be valid" do
    category = Category.new(name: "Sports")

    assert category.valid?
  end

  test "name should be present" do
    category = Category.new(name: " ")

    assert_not category.valid?
  end

  test "name should be unique" do
    Category.new(name: "Sports").save
    category_two = Category.new(name: "Sports")

    assert_not category_two.valid?
  end

  test "name should not be too long" do
    category = Category.new(name: "This is a really, really, really long category name that should not be valid")

    assert_not category.valid?
  end

  test "name should not be too short" do
    category = Category.new(name: "Yo")

    assert_not category.valid?
  end
end
