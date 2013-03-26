require 'minitest/spec'
require 'minitest/autorun'
require 'parser'

describe Parser do
  describe "#courses_file?" do
    it "must return true if the csv is a list of courses" do
      parser = Parser.new
      parser.courses_file?("data/001.csv").must_equal true
    end

    it "must return false if the csv file is not a list of courses" do
      parser = Parser.new
      parser.courses_file?("data/002.csv").must_equal false
    end
  end

  describe "#enrollments_file?" do
    it "must return true if the csv file is a list of enrollments" do
      parser = Parser.new
      parser.enrollments_file?("data/003.csv").must_equal true
    end

    it "must return false if the csv file is not a list of enrollments" do
      parser = Parser.new
      parser.enrollments_file?("data/001.csv").must_equal false
    end
  end

  describe "#users_file?" do
    it "must return true if the csv file is a list of users" do
      parser = Parser.new
      parser.users_file?("data/002.csv").must_equal true
    end

    it "must return false if the csv file is not a list of users" do
      parser = Parser.new
      parser.users_file?("data/001.csv").must_equal false
    end
  end
end
