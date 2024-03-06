require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = User.new(
      username: 'testuser',
      usersurname: 'testsurname',
      email: 'test@example.com',
      password: 'Test1234',
      password_confirmation: 'Test1234',
      role: 2
    )
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'username should be present' do
    @user.username = '  '
    assert_not @user.valid?
  end

  test 'usersurname should be present' do
    @user.usersurname = '  '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '  '
    assert_not @user.valid?
  end

  test 'email should be unique' do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test 'email should be valid' do
    @user.email = 'invalid_email'
    assert_not @user.valid?
  end

  test 'password should be present' do
    @user.password = @user.password_confirmation = ' ' * 8
    assert_not_nil @user.errors[:password]
  end


  test 'password should have proper complexity' do
    @user.password = @user.password_confirmation = 'password'
    assert_not @user.valid?
  end

  test 'registered_for? should return correct value' do
    event = Event.create(
      title: 'Test Event',
      event_type: 'Conference',
      place: 'Test Location',
      num_of_people: 100,
      description: 'This is a test event.',
      event_date: DateTime.now + 1.week,
      user: @user
    )

    assert_not @user.registered_for?(event)

    registration = Registration.create(event: event, user: @user)

    assert @user.registered_for?(event)
  end

  test 'author? should return correct value' do
    event = Event.create(
      title: 'Test Event',
      event_type: 'Conference',
      place: 'Test Location',
      num_of_people: 100,
      description: 'This is a test event.',
      event_date: DateTime.now + 1.week,
      user: @user
    )

    comment = Comment.create(body: 'Test Comment', event: event, user: @user)

    assert @user.author?(event)
    assert @user.author?(comment)

    other_user = User.create(
      username: 'otheruser',
      usersurname: 'othersurname',
      email: 'other@example.com',
      password: 'Test1234',
      password_confirmation: 'Test1234'
    )

    assert_not other_user.author?(event)
    assert_not other_user.author?(comment)
  end

  test 'guest? should return correct value' do
    assert_not @user.guest?
  end
end
