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
  end
end
