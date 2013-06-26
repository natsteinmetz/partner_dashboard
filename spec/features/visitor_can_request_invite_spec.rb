require 'spec_helper'

feature "Visitor" do

  let!(:invite_request){ create_invite_request }

  # There has to be an admin user that wants to accept requests
  let!(:admin) { FactoryGirl.create(:admin_user) }

  scenario "can request invite with valid information" do
    request_invite(invite_request)
    page.should have_content "An invitation request has been sent to the admin."
  end

  scenario "cannot request invite with invalid information"
end
