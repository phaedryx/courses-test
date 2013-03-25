class Enrollment
  attr_accessor :course_id, :user_id, :state

  def initialize(args)
    
  end

  def ==(comparison_enrollment)
    self.course_id == comparison_enrollment.course_id && self.user_id == comparison_enrollment.user_id 
  end
end
