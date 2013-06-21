require 'spec_helper'

describe Admin::PartnersController do
  context "no user signed in" do
    it "does not show partners" do
      get :index
      response.should redirect_to(new_user_session_path)
      flash[:alert].should eql(I18n.t "devise.failure.unauthenticated")
    end
  end

  context "normal user signed in" do
    before do
      user = FactoryGirl.create(:confirmed_user)
      sign_in :user, user
    end

    it "does not show partners" do
      get :index
      response.should redirect_to(root_path)
      flash[:alert].should eql("You must be an admin to do that.")
    end
  end
end
