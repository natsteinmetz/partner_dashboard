require 'spec_helper'

describe StudentsController do
  context "no user signed in" do
    it "does not show students to non-users" do
      get :index
      response.should redirect_to(new_user_session_path)
      flash[:alert].should eql(I18n.t "devise.failure.unauthenticated")
    end
  end
end
