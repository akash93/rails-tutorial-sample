require 'test_helper'

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @relationship = Relationship.new(follower_id: users(:test).id, followed_id: users(:admin).id)
  end

  test 'should be valid' do
    assert @relationship.valid?
  end

  test 'should require a follower id' do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test 'should require followed id' do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
