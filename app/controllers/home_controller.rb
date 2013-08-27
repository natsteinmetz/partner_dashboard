#Controller used for public actions
class HomeController < ApplicationController
  def index
    flash.keep
    if current_user.nil?
      redirect_to new_user_session_path
    elsif current_user.has_role? :admin
      redirect_to admin_relationships_path
    elsif current_user.profile
      if current_user.has_role? :professional
        redirect_to dashboard_path
      else #user is a student
        redirect_to student_path(current_user)
      end
    else
      redirect_to edit_user_registration_path(current_user)
    end
  end
end
