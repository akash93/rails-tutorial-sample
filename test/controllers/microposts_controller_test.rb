require 'test_helper'

class MicropostsControllerTest < ActionDispatch::IntegrationTest

  def setup
    @post = microposts(:random_post)
  end

  test 'should redirect create when not logged in' do
    assert_no_difference 'Micropost.count' do
      post microposts_path, params: { micropost: { content: 'Random text' } }
    end
    assert_redirected_to login_url
  end

  test 'should redirect destroy when not logged in' do
    assert_no_difference 'Micropost.count' do
      delete micropost_path(@post)
    end
    assert_redirected_to login_url
  end
end
