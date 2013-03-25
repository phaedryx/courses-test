require 'csv'

class Parser
  COURSES_HEADERS     = ["course_id", "course_name", "state"]
  ENROLLMENTS_HEADERS = ["course_id", "user_id", "state"]
  USERS_HEADERS       = ["user_id", "user_name", "state"]

  def initialize(args)
    
  end
  
  def self.courses_file?(path)
    file_headers = CSV.open(path).shift
    file_headers == COURSES_HEADERS
  end

  def self.enrollments_file?(path)
    file_headers = CSV.open(path).shift
    file_headers == ENROLLMENTS_HEADERS    
  end

  def self.users_file?(path)
    file_headers = CSV.open(path).shift
    file_headers == USERS_HEADERS
  end
end
