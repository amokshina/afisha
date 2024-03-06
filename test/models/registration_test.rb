require 'test_helper'

class RegistrationTest < ActiveSupport::TestCase
  test 'should belong to event and user' do
    registration = Registration.new
    assert_not registration.save, 'Saved the registration without an event and user'
  end

end