ENV['RAILS_ENV'] ||= 'test'
ENV['TZ'] = 'UTC'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def file_data(name)
    File.read(Rails.root.to_s + "/test/support/files/#{name}")
  end

  # Implementation of the Guard Assertion unit testing pattern.  This should
  # be used to assert that preconditions of external dependancies are valid
  # before executing the test.  Dependencies external to the test are things
  # like fixtures or mocks.  The test depends on how they act but does not
  # create them so their behavior may change unexpectedly over time.
  #
  # Note: The name is assert_guard rather than guard_assert so that the test
  #       framework will know what line to show for the test failure since it
  #       following the naming convention assert_*.
  # 
  # Reference: http://xunitpatterns.com/Guard%20Assertion.html
  #
  # Example:
  # 
  #   assert_guard network_events(:tuggle_network).program.present?,
  #     "Network event fixture expected to have a program"
  # 
  def assert_guard(condition, message)
    assert condition, "Assert Guard: #{message}"
  end
  
  # Assertion that ensures a collection or ActiveRecord scopish object has 
  # pagination.  A direct way of testing could not be found so an indirect
  # test is used that checks for a pagination specific method existing.
  #
  # Example:
  # 
  #   assert_pagination assigns(:network_events), 
  #     "Network events should be listed with pagination."
  #
  def assert_pagination(collection, message='')
    assert collection.respond_to?(:total_pages), message
  end
  
  # Refutation that ensures a collection or ActiveRecord scopish object does 
  # not have pagination.  A direct way of testing could not be found so an 
  # indirect test is used that checks for a pagination specific method 
  # not existing on the collection.
  #
  # Example:
  # 
  #   refute_pagination assigns(:network_events), 
  #     "Network events should be exported without pagination."
  #
  def refute_pagination(collection, message='')
    refute collection.respond_to?(:total_pages), message
  end
  
end
