require 'spec_helper'

feature "Visitor" do
  before do
    visit '/'
    click_link "Request Invite"
  end

  scenario "can request invite with valid information" do

    #Fill in email and message to admin
    fill_in "Company", with: "Acme"
    fill_in "Role (optional)", with: "Hiring Manager"
    fill_in "Message to Admin", with: "Please add me to partner dashboard."
    click_button "Submit"
    page.should have_content "Invitation request sent to admin."
  end

  scenario "cannot request invite with invalid information"
end