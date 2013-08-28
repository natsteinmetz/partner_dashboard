class StudentsController < ApplicationController
  before_filter :authenticate_user!

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
end
