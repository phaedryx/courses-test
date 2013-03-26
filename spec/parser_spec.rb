require 'minitest/spec'
require 'minitest/autorun'
require 'parser'

describe Parser do
  describe "#courses_file?" do
    before do
      @parser = Parser.new
    end

    it "must return true if the csv is a list of courses" do
      @parser.courses_file?("data/001.csv").must_equal true
    end

    it "must return false if the csv file is not a list of courses" do
      @parser.courses_file?("data/002.csv").must_equal false
    end
  end

  describe "#enrollments_file?" do
    before do
      @parser = Parser.new
    end

    it "must return true if the csv file is a list of enrollments" do
      @parser.enrollments_file?("data/003.csv").must_equal true
    end

    it "must return false if the csv file is not a list of enrollments" do
      @parser.enrollments_file?("data/001.csv").must_equal false
    end
  end

  describe "#users_file?" do
    before do
      @parser = Parser.new
    end

    it "must return true if the csv file is a list of users" do
      @parser.users_file?("data/002.csv").must_equal true
    end

    it "must return false if the csv file is not a list of users" do
      @parser.users_file?("data/001.csv").must_equal false
    end
  end

  describe "#import_file!" do
    before do
      @parser = Parser.new
    end

    it "must raise an error if it isn't a known type" do
      -> { @parser.import_file!("test_data/empty.csv") }.must_raise Parser::UnknownFileError
    end

    it "must import course files" do
      course = Course.new(course_id: "C628944", course_name: "Suicide", state: "active")
      @parser.import_file!("test_data/course.csv")
      @parser.courses.include?(course).must_equal true
    end

    it "must import enrollment files" do
      enrollment = Enrollment.new(course_id: "C126767", user_id: "U511908", state: "active")
      @parser.import_file!("test_data/enrollment.csv")
      @parser.enrollments.include?(enrollment).must_equal true
    end

    it "must import user files" do
      user = User.new(user_id: "U531649", username: "Noah Thomas", state: "active")
      @parser.import_file!("test_data/user.csv")
      @parser.users.include?(user).must_equal true
    end

    it "must replace a course with its modified version if encountered" do
      parser = Parser.new
      parser.import_file!("test_data/course.csv")
      parser.import_file!("test_data/modified_course.csv")
      parser.courses.size.must_equal 1 # replaced, not appended
      parser.courses.first.course_name.must_equal "Suicidal Psychology"
    end

    it "must replace an enrollment with its modified version if encountered" do
      parser = Parser.new
      parser.import_file!("test_data/enrollment.csv")
      parser.import_file!("test_data/modified_enrollment.csv")
      parser.enrollments.size.must_equal 1 # replace, not appended
      parser.enrollments.first.state.must_equal "deleted"
    end

    it "must replace a user with its modified version if encountered" do
      parser = Parser.new
      parser.import_file!("test_data/user.csv")
      parser.import_file!("test_data/modified_user.csv")
      parser.users.size.must_equal 1 # replaced
      parser.users.first.user_name.must_equal "Noah J. Thomas"
    end
  end

  describe "#active_courses" do
    it "must return active courses" do
      parser = Parser.new
      course = Course.new(course_id: "C732380")
      parser.import_file!("data/001.csv")
      parser.active_courses.include?(course).must_equal true
    end
  end

  describe "#active_enrollments" do
    it "must return active enrollments" do
      parser = Parser.new
      enrollment = Enrollment.new(course_id: "C300581", user_id: "U824115")
      parser.import_file!("data/003.csv")
      parser.active_enrollments.include?(enrollment).must_equal true
    end
  end

  describe "#active_users" do
    it "must return active users" do
      parser = Parser.new
      user = User.new(user_id: "U213037")
      parser.import_file!("data/002.csv")
      parser.active_users.include?(user).must_equal true
    end
  end
end
