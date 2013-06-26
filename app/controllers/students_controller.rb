class StudentsController < ApplicationController
  before_filter :authenticate_user!
  #TODO: Add before filter to ensure user's partner has a relationship
  before_filter :confirm_relationship, only: :show

  def index
    # Eager load students to check relationship status
    unless current_user.admin?
      current_user.partner = Partner.includes(:students).find(current_user.partner.id)
    end
    @students = Student.includes(:courses).order("name")
  end

  def show
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
