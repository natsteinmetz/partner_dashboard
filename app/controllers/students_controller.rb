class StudentsController < ApplicationController
  before_filter :authenticate_user!
  #TODO: Add before filter to ensure user's partner has a relationship
  #before_filter :confirm_relationship, only: :show FIX ME

  def index
    @students = Student.includes(:courses).order("name")
  end

  def show
    @student = Student.find(params[:id])
  end

  def edit
    @student = Student.find(params[:id])
  end

  def update
    @student = Student.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Profile has been updated."
      redirect_to @student
    else
      flash[:alert] = "Profile has not been updated."
      render action: "edit"
    end
  end

private
  def confirm_relationship
    @student = Student.find(params[:id])
    unless current_user.connected?(@student)
      flash[:alert] = "You do not have permission to view this user"
      redirect_to students_path
    end
  end
end
