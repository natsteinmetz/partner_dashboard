class StudentsController < ApplicationController
  before_filter :authenticate_user!
  #TODO: Add before filter to ensure user's partner has a relationship

  def index
    @students = Student.order("name")
  end

  def show
    @student = Student.find(params[:id])
  end

end
