class User
  attr_accessor :user_id, :user_name, :state

  def initialize(args = {})
    @user_id   = args[:user_id]
    @user_name = args[:user_name]
    @state     = args[:state]
  end

  def ==(comparison_user)
    self.user_id == comparison_user.user_id
  end

  def active?
    self.state == "active"
  end
end
