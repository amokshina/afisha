require 'test_helper'

class EventsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one) # Предполагается, что у вас есть фикстура users.yml с хотя бы одним пользователем
    @event = events(:one) # Предполагается, что у вас есть фикстура events.yml с хотя бы одним мероприятием
  end

  test "should get index" do
    get events_url
    assert_response :success
  end

  test 'should show event' do
    get event_url(@event)
    assert_response :success
  end

end