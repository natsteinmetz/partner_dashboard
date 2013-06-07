#Controller used for public actions

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

  def request_invite
  end

  def send_invite
    flash[:notice] = "An invitation request has been sent to the admin."
    AdminMailer.invite_request(params[:form_fields]).deliver
    redirect_to new_user_session_path
  end
end
