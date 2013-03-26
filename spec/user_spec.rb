require 'minitest/spec'
require 'minitest/autorun'
require 'user'

describe User do
  describe "#==" do
    it "must return true if the user id's are the same" do
      original_user = Course.new(user_id: "U1", user_name: "original", state: "active")
      comparison_user = Course.new(user_id: "U1", user_name: "could be different", state: "inactive")
      (original_user == comparison_user).must_equal true
    end
  end

  describe "#active?" do
    it "must return true if the user has an active state" do
      user = User.new
      user.state = "active"
      user.active?.must_equal true
    end

    it "must return false if the user state is not active" do
      user = User.new
      user.state = "deleted"
      user.active?.must_equal false
    end
  end
end
