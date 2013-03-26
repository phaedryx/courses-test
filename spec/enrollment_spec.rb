require 'minitest/spec'
require 'minitest/autorun'
require 'course'
require 'user'
require 'enrollment'

describe Enrollment do
  describe "#==" do
    it "must return true if the course id's and user id's are the same" do
      original_enrollment = Enrollment.new(course_id: "C1", user_id: "U1", state: "active")
      comparison_enrollment = Enrollment.new(course_id: "C1", user_id: "U1", state: "deleted")
      (original_enrollment == comparison_enrollment).must_equal true
    end
  end

  describe "#active?" do
    it "must return true if it is active and its user and course are active" do
      course = Course.new(state: "active")
      user   = User.new(state: "active")
      enrollment = Enrollment.new(course: course, user: user, state: "active")
      enrollment.active?.must_equal true
    end
  end
end
