class StudentsController < ApplicationController
  before_filter :authenticate_user!
  #TODO: Add before filter to ensure user's partner has a relationship
  #before_filter :confirm_relationship, only: :show FIX ME

  def index
    @students = User.with_role :student
  end

  def show
    @student = User.find(params[:id])
  end

  def edit
    @student = User.find(params[:id])
  end

  def update
    @student = User.find(params[:id])
    if @student.update_attributes(params[:student])
      flash[:notice] = "Profile has been updated."
      redirect_to student_path(@student)
    else
      flash[:alert] = "Profile has not been updated."
      render action: "edit"
    end
  end

private
  def confirm_relationship
    @student = User.find(params[:id])
    unless current_user.connected?(@student)
      flash[:alert] = "You do not have permission to view this user"
      redirect_to students_path
    end
  end
end
