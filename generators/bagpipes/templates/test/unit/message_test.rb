require 'test_helper'

class MessageTest < ActiveSupport::TestCase
  test "should require content" do
    m = Message.new
    assert !m.valid?
    assert m.errors.on(:content)
  end
  
  test "should belong to a topic" do
    assert Message.new.respond_to?(:topic)
  end
  
  test "should have a parent" do
    assert Message.new.respond_to?(:parent)
  end

  test "should have children" do
    assert Message.new.respond_to?(:children)
  end
end
