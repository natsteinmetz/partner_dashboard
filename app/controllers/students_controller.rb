class StudentsController < ApplicationController
  before_filter :authenticate_user!

  def index
    @students = Student.order("name")
  end
end
