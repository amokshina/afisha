require "test_helper"

class CommentTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @event = events(:one)
    @comment = Comment.new(
      body: 'This is a test comment.',
      user: @user,
      event: @event,
      created_at: DateTime.now,
      updated_at: DateTime.now
    )
  end

  test 'should be valid' do
    assert @comment.valid?
  end

  test 'body should be present' do
    @comment.body = '  '
    assert_not @comment.valid?
  end

  test 'body should have minimum length' do
    @comment.body = 'a'
    assert_not @comment.valid?
  end

  test 'user should be present' do
    @comment.user = nil
    assert_not @comment.valid?
  end

  test 'event should be present' do
    @comment.event = nil
    assert_not @comment.valid?
  end

  test 'formatted_created_at should return formatted date and time' do
    formatted_time = @comment.formatted_created_at
    expected_formatted_time = @comment.created_at.strftime('%Y-%m-%d %H:%M:%S')
    assert_equal expected_formatted_time, formatted_time
  end
end
