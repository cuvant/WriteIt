require 'test_helper'

class MicropostTest < ActiveSupport::TestCase

  def setup
    @user = users(:rares)
    # This code is not idiomatically correct.
    @micropost = @user.microposts.build(description: "Lorem ipsum", address: "bla", latitude: 1.0, longitude: 1.0, user_id: @user.id)
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end
end
