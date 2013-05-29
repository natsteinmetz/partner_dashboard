class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @all_students = Student.order("name")
    @contacted_students = current_user.partner.students
  end
end
