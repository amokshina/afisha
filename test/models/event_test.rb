require 'test_helper'

class EventTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @event = Event.new(
      title: 'Test Event',
      event_type: 'Other',
      place: 'Test Location',
      num_of_people: 100,
      description: 'This is a test event.',
      event_date: DateTime.now + 1.week,
      user: @user
    )
  end

  test 'should be valid' do
    assert @event.valid?
  end

  test 'title should be present' do
    @event.title = '  '
    assert_not @event.valid?
  end

  test 'event_type should be present' do
    @event.event_type = '  '
    assert_not @event.valid?
  end

  test 'place should be present' do
    @event.place = '  '
    assert_not @event.valid?
  end

  test 'num_of_people should be present' do
    @event.num_of_people = nil
    assert_not @event.valid?
  end

  test 'num_of_people should be greater than 0' do
    @event.num_of_people = 0
    assert_not @event.valid?
  end

  test 'description should be present' do
    @event.description = '  '
    assert_not @event.valid?
  end

  test 'event_date should be present' do
    @event.event_date = nil
    assert_not @event.valid?
  end


  test 'available_spots should return correct value' do
    assert_equal @event.num_of_people, @event.available_spots

    Registration.create(event: @event, user: @user)

    assert_equal(@event.num_of_people - 1, @event.available_spots)
  end
end
