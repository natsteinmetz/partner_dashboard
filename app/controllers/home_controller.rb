#Controller used for public actions
class HomeController < ApplicationController
  def index
    flash.keep
    if current_user.nil?
      redirect_to new_user_session_path
    elsif current_user.admin?
      redirect_to admin_relationships_path
    elsif current_user.partner_id.is_a? Integer
      redirect_to dashboard_path
    else
      @student = Student.find(current_user.student_id)
      redirect_to student_path(@student)
    end
  end
end
