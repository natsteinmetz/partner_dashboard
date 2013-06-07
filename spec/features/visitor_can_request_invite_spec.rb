require 'spec_helper'

feature "Visitor" do
  let!(:potential_user){ create_potential_user }

  scenario "can request invite with valid information" do
    request_invite(potential_user)
    page.should have_content "An invitation request has been sent to the admin."
  end

  scenario "cannot request invite with invalid information"
end