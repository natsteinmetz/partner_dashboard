require 'spec_helper'

feature "Contacting students" do
  let!(:user) { FactoryGirl.create(:confirmed_user) }
  let!(:student) { FactoryGirl.create(:student) }

  before do
    sign_in_as!(user)
    visit "/"
    click_button "Contact"
  end

  scenario "requesting contact with a particular student" do
    page.current_path.should == students_path
    page.should have_content("You successfully requested contact with #{student.name}.")
  end

  scenario "users see which students they have requested contact with" do
    within "#students tbody" do
      page.should have_content("Pending")
    end
  end

  scenario "users see when their contact request is accepted"
end
