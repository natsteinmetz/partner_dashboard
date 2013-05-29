require 'spec_helper'

describe StudentsController do
  context "no user signed in" do
    it "does not show students to non-users" do
      get :index
      response.should redirect_to new_user_session_url
      flash[:alert].should eql("You need to sign in or sign up before continuing.")
    end
  end
end
