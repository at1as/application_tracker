require 'test_helper'

class CompanyTest < ActiveSupport::TestCase
  test "should not save company without params" do
    company = Company.new
    assert_not company.save, "Saved company without any params"
  end
  
  test "should not save company without status" do
    company = Company.new(:name => "company 123")
    assert_not company.save, "Saved company without any status"
  end
  
  test "should not save company without name" do
    company = Company.new(:status => "Applied")
    assert_not company.save, "Saved company without a name"
  end
  
  test "should not save company with blank name" do
    company = Company.new(:name => "", :status => "Applied")
    assert_not company.save, "Saved company without a name"
  end
  
  test "should not save company with blank status" do
    company = Company.new(:name => "company 123", :status => "")
    assert_not company.save, "Saved company without a status"
  end
  
  test "should save company with correct params" do
    company = Company.new(:name => "company 123", :status => "Applied")
    assert company.save, "Did not save company with correct params"
  end
  
  test "should not save company with already used name" do
    company_1 = Company.new(:name => "company 123", :status => "Applied")
    assert company_1.save, "Did not save company with correct params"
    company_2 = Company.new(:name => "company 123", :status => "Applied")
    assert_not company_2.save, "Saved company with already used name - same case"
    company_3 = Company.new(:name => "COMPANY 123", :status => "Applied")
    assert_not company_3.save, "Saved company with already used name - different case"
  end
end
