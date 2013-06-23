class InviteRequestsController < ApplicationController
  def new
    @invite_request = InviteRequest.new
  end

  def create
    @invite_request = InviteRequest.new(params[:invite_request])
    if @invite_request.valid?
      #Creating invite_request again because valid? adds weird errors parameter
      @invite_request = InviteRequest.new(params[:invite_request])
      flash[:notice] = "An invitation request has been sent to the admin."
      AdminMailer.invite_request(@invite_request).deliver
      redirect_to new_user_session_path
    else
      render :new
    end
  end
end