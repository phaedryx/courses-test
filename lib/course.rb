class Course
  attr_accessor :course_id, :course_name, :state

  def initialize(args = {})
    @course_id   = args[:course_id]
    @course_name = args[:course_name]
    @state       = args[:state]
  end

  def ==(comparison_course)
    self.course_id == comparison_course.course_id
  end

  def active?
    self.state == "active"
  end
end
