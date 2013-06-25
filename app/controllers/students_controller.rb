class StudentsController < ApplicationController
  before_filter :authenticate_user!
  #TODO: Add before filter to ensure user's partner has a relationship

  def index
    current_user.partner = Partner.includes(:students).find(current_user.partner.id)
    @students = Student.includes(:courses).order("name")
  end

  def show
    @student = Student.find(params[:id])
  end

end
