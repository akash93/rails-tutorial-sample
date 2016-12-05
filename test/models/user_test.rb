require 'test_helper'

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(name: 'user', email:'user@exle.com',
                    password: 'test_password', password_confirmation: 'test_password')
  end

  test 'should be valid' do
    assert @user.valid?
  end

  test 'name should be present' do
    @user.name = '    '
    assert_not @user.valid?
  end

  test 'email should be present' do
    @user.email = '  '
    assert_not @user.valid?
  end

  test 'name should not be too long' do
    @user.name = 'a' * 51
    assert_not @user.valid?
  end

  test 'email should not be too long' do
    @user.email = 'a' * 244 + '@example.com'
    assert_not @user.valid?
  end

  test 'email validation should accept valid email addresses' do
    valid_addresses = %w[user@emple.com US@F.CO.OM a-D_a@a.CO.in a.v@co.ne.in]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end 
  end

  test 'email validation should reject invalid email addresses' do
    invalid_addresses = %w[a@b,com a.at.b.com a_at_b.com a@b. eg@a_v.com a@b+c.com a@v..cm]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test 'email address should be unique' do
    dup_user = @user.dup
    @user.save
    assert_not dup_user.valid?
    dup_user.email.upcase!
    assert_not dup_user.valid?
  end

  test 'user email should be saved in lowercase' do
    email = "Akas@ES.AA.in"
    @user.email = email
    @user.save
    assert_equal email.downcase, @user.reload.email
  end

  test 'password should not be blank' do
    @user.password = @user.password_confirmation = " " * 8
    assert_not @user.valid?
  end

  test 'password should have a minimum length' do
    @user.password = @user.password_confirmation = "a" * 7
    assert_not @user.valid?
  end

  test 'authenticated? should return false for user with nil digest' do
    assert_not @user.authenticated?('')
  end


end
