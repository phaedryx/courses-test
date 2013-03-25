require 'minitest/spec'
require 'minitest/autorun'
require 'enrollment'

describe Enrollment do
  describe "#==" do
    it "must return true if the course id's and user id's are the same" do
      original_enrollment = Enrollment.new(course_id: "C1", user_id: "U1", state: "active")
      comparison_enrollment = Enrollment.new(course_id: "C1", user_id: "U1", state: "deleted")
      (original_enrollment == comparison_enrollment).must_equal true
    end
  end  
end
