require 'test_helper'

class UsersShowTest < ActionDispatch::IntegrationTest

  def setup
    @admin = users(:admin)
    @other_user = users(:deactivated_user)
  end

  test 'user page for deactivated user redirects to root' do
    log_in_as @admin
    get user_path @other_user
    assert_redirected_to root_url
  end

end

