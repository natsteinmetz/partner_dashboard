class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @all_students = Student.order("name")
  end
end
