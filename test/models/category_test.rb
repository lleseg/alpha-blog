# frozen_string_literal: true

require "test_helper"

class CategoryTest < ActiveSupport::TestCase
  setup do
    @category = Category.new(name: "Sports")
  end

  test "category should be valid" do
    assert @category.valid?
  end

  test "name should be present" do
    @category.name = " "

    assert_not @category.valid?
  end

  test "name should be unique" do
    @category.save
    @category_two = Category.new(name: "Sports")

    assert_not @category_two.valid?
  end

  test "name should not be too long" do
    @category.name = "This is a really, really, really long category name that should not be valid"

    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category.name = "Yo"

    assert_not @category.valid?
  end
end
