require 'test_helper'

class EventTest < ActiveSupport::TestCase
  test "should not save event without params" do
    event = Event.new
    assert_not event.save, "Saved event without params"
  end
  
  test "should not save event with blank date" do
    event = Event.new(:date => '')
    assert_not event.save, "Saved event with blank date"
  end
  
  test "should save event with valid params" do
    event = Event.new(:date => "2016-01-01")
    assert event.save, "Did not save event with valid params"
  end
end
