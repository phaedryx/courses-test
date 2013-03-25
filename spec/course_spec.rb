require 'minitest/spec'
require 'minitest/autorun'
require 'course'

describe Course do
  describe "#==" do
    it "must return true if the course id's are the same" do
      original_course = Course.new(course_id: "C1", course_name: "original", state: "active")
      comparison_course = Course.new(course_id: "C1", course_name: "could be different", state: "inactive")
      (original_course == comparison_course).must_equal true
    end
  end
end
