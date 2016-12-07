require 'test_helper'

class MicropostTest < ActiveSupport::TestCase 
  def setup
    @user = users(:test)
    @post = @user.microposts.build(content: 'Random text')
  end

  test 'should be valid' do
    assert @post.valid?
  end

  test 'user id should be present' do
    @post.user_id = nil
    assert_not @post.valid?
  end

  test 'content should be present' do 
    @post.content = '  '
    assert_not @post.valid?
  end

  test 'content should be less than 140 chars' do
    @post.content = 'a' * 141
    assert_not @post.valid?
  end

  test 'post should be ordered by most recent first' do
    assert_equal microposts(:most_recent), Micropost.first
  end
end
