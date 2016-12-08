require 'test_helper'

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test 'post interface' do
    log_in_as @user
    get root_path
    assert_select 'div.pagination'
    assert_select 'input[type=file]'
  end

  test 'invalid submission shows errors' do
    log_in_as @user
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: '' } }
    end
    assert_select 'div#error_explanation'
  end

  test 'valid submission shows up' do
    log_in_as @user
    content = 'Random post'
    picture = fixture_file_upload('test/fixtures/rails.png', 'image/png')
    assert_difference 'Micropost.count', 1 do
      post microposts_path, params: { micropost: { content: content, picture: picture } }
    end
    assert_redirected_to root_url
    follow_redirect!
    assert_match content, response.body
  end

  test 'delete post ' do
    log_in_as @user
    get root_path
    assert_select 'a', text: 'delete'
    first_post = @user.microposts.paginate(page: 1).first
    assert_difference 'Micropost.count', -1 do
      delete micropost_path(first_post)
    end
    assert_not flash.empty?
  end

  test 'user should not be able to delete other user posts' do
    log_in_as @user
    get user_path(users(:admin))
    assert_select 'a', text: 'delete', count:0
  end

  test 'sidebar should show correct count' do
    log_in_as @user
    get root_path
    post_count = @user.microposts.count
    assert_match "#{post_count} microposts", response.body
  end
end
