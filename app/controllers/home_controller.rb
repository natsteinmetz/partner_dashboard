class HomeController < ApplicationController
  def index
    flash.keep
    if current_user.nil?
      redirect_to new_user_session_path
    elsif current_user.admin?
      redirect_to admin_professionals_path
    else
      redirect_to students_path
    end
  end
end
