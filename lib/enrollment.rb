class Enrollment
  attr_accessor :course, :user, :state

  def initialize(args = {})
    @course = args[:course]
    @user   = args[:user]
    @state  = args[:state]
  end

  def ==(enrollment)
    self.course == enrollment.course && self.user == enrollment.user
  end

  def active?
    self.state == "active" && self.course.active? && self.user.active?
  end
end
