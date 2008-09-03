require 'test_helper'

class TopicTest < ActiveSupport::TestCase
  test "should require a title" do
    t = Topic.new
    assert !t.valid?
    assert t.errors.on(:title)
    t.title = "Test Topic"
    assert t.valid?
  end
  
  test "should have many messages" do
    assert_equal [], Topic.new.messages
  end
end
