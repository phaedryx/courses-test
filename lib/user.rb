class User
  attr_accessor :user_id, :user_name, :state

  def initialize(args)
    
  end

  def ==(comparison_user)
    self.user_id == comparison_user.user_id
  end
end
