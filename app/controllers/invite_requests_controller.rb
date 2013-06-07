class InviteRequestsController < ApplicationController
  def new
    @invite_request = InviteRequest.new
  end

  def create
    @invite_request = InviteRequest.new(params[:invite_request])
    flash[:notice] = "An invitation request has been sent to the admin."
    AdminMailer.invite_request(@invite_request).deliver
    redirect_to new_user_session_path
  end
end