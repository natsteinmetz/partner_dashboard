require 'spec_helper'

feature "Viewing profiles" do
  let!(:profile_1) { FactoryGirl.create(:profile) }
  let!(:user) {FactoryGirl.create(:confirmed_user)}

  before do
    sign_in_as!(user)
    visit "/"
    click_link "Profile"
  end

  scenario "see user profile page" do
    page.should have_content("Profile")
  end
end
