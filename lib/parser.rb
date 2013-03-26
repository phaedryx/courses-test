require 'csv'
require_relative 'course'
require_relative 'enrollment'
require_relative 'user'

class Parser
  class UnknownFileError < StandardError;  end

  COURSES_HEADERS     = ["course_id", "course_name", "state"]
  ENROLLMENTS_HEADERS = ["course_id", "user_id", "state"]
  USERS_HEADERS       = ["user_id", "user_name", "state"]

  attr_reader :courses, :enrollments, :users

  def initialize()
    @courses     = []
    @users       = []
    @enrollments = []
  end
  
  def import_file!(path)
    if courses_file?(path)
      import_courses(path)
    elsif enrollments_file?(path)
      import_enrollments(path)
    elsif users_file?(path)
      import_users(path)
    else
      raise UnknownFileError, "File doesn't match a known file format"
    end
  end

  def courses_file?(path)
    file_headers = CSV.open(path).shift
    file_headers == COURSES_HEADERS
  end

  def enrollments_file?(path)
    file_headers = CSV.open(path).shift
    file_headers == ENROLLMENTS_HEADERS    
  end

  def users_file?(path)
    file_headers = CSV.open(path).shift
    file_headers == USERS_HEADERS
  end

  def active_courses
    @courses.find_all {|c| c.active?}
  end

  def active_enrollments
    @enrollments.find_all {|e| e.active?}
  end

  def active_users
    @users.find_all {|u| u.active?}
  end

private
  def import_courses(path)
    CSV.foreach(path, headers: true) do |row|
      course = Course.new(course_id: row["course_id"], course_name: row["course_name"], state: row["state"])
      index  = @courses.index(course)

      index ? @courses[index] = course : @courses << course
    end
  end

  def import_enrollments(path)
    CSV.foreach(path, headers: true) do |row|
      course     = @courses.find {|c| c.course_id == row["course_id"]}
      user       = @users.find {|u| u.user_id == row["user_id"]}
      enrollment = Enrollment.new(course: course, user: user, state: row["state"])
      index      = @enrollments.index(enrollment)

      index ? @enrollments[index] = enrollment : @enrollments << enrollment
    end
  end

  def import_users(path)
    CSV.foreach(path, headers: true) do |row|
      user = User.new(user_id: row["user_id"], user_name: row["user_name"], state: row["state"])
      index = @users.index(user)

      index ? @users[index] = user : @users << user
    end
  end
end
