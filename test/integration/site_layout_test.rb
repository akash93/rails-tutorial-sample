require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:test)
  end

  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    assert_select 'a[href=?]', help_path
    get contact_path
    assert_select 'title', full_title('Contact')
    get help_path
    assert_select 'title', full_title('Help')
    get signup_path
    assert_select 'title', full_title('Sign up')
    get login_path
    assert_select 'title', full_title('Login')
    
  end

  test  'logged in links' do
    get login_path
    log_in_as(@user)
    assert_redirected_to user_path(@user)
    get users_path
    assert_select 'title', full_title('Users')
    get edit_user_path(@user)
    assert_select 'title', full_title('Edit user')
    delete logout_path
    assert_redirected_to root_url
  end

end
