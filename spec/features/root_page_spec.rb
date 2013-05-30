#TODO rename this spec something else

require 'spec_helper'

feature "Root page" do

  scenario "Visiting root page shows an informative sign in page" do
    #Test for sign in form
    visit '/'
    page.should have_button("Sign in")
    #Test for link to request admin invite
    page.should have_link("Request Invitation")
  end

  scenario "Root page has links to other codefellows sites and the about page"
end