require 'test_helper'

class ContactTest < ActiveSupport::TestCase
  test "should not save contact without name" do
    contact = Contact.new
    assert_not contact.save, "Saved contact without a name"
  end
  
  test "should not save contact with blank name" do
    contact = Contact.new(:name => "")
    assert_not contact.save, "Saved contact without a name"
  end
  
  test "should not save contact with already used name" do
    contact_1 = Contact.new(:name => "John Galt")
    assert contact_1.save, "Did not save contact with valid credentials"
    contact_2 = Contact.new(:name => "John Galt")
    assert_not contact_2.save, "Saved contacted contact with already used credentials (same case)"
    contact_3 = Contact.new(:name => "john galt")
    assert_not contact_3.save, "Saved contacted contact with already used credentials (different case)"
  end
  
  test "should not save contact with invalid email" do
    contact = Contact.new(:name => "hello", :email => "hello@world")
    assert_not contact.save, "Saved contact with invalid email"
  end
  
  test "should save contact with valid email" do
    contact = Contact.new(:name => "hello", :email => "hello@world.com")
    assert contact.save, "Did not save contact with valid email"
  end
  
  test "should not save contact with invalid phone number" do
    contact = Contact.new(:name => "hello", :phone => "+1-555-555-555")
    assert_not contact.save, "Saved contact with invalid email"
  end
  
  test "should save contact with valid phone number" do
    contact = Contact.new(:name => "hello", :phone => "+1-555-555-5555")
    assert contact.save, "Did not save contact with valid phone number"
  end
end
