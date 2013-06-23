require "spec_helper"

feature "Signing up" do
  scenario "signup link is not shown" do
    visit "/"
    page.current_path.should eql(new_user_session_path)
    assert_no_link_for "Sign up"
  end

  scenario "signing up is not allowed" do
    expect{ visit "/users/sign_up" }.to raise_error(ActionController::RoutingError)
  end
end
