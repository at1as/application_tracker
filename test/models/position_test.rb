require 'test_helper'

class PositionTest < ActiveSupport::TestCase
  test "should not save position without params" do
    position = Position.new
    assert_not position.save, "position saved without params"
  end
  
  test "should not save position with blank name" do
    position = Position.new(:name => '')
    assert_not position.save, "position saved with blank name"
  end
  
  test "should not save position with duplicate name" do
    position_1 = Position.new(:name => 'hello')
    assert position_1.save, "position did not save with valid name"
    position_2 = Position.new(:name => 'hello')
    assert_not position_2.save, "position saved with already used name - same case"
    position_3 = Position.new(:name => 'Hello')
    assert_not position_3.save, "position saved with already used name - different case"
  end
  
  test "should save position with valid name" do
    position = Position.new(:name => 'valid name')
    assert position.save, "position did not save with valid name"
  end
end
