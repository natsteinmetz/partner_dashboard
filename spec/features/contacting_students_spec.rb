require 'spec_helper'

feature "Contacting students" do
  let!(:student) { FactoryGirl.create(:student) }

  context "as a normal user" do
    let(:user) { FactoryGirl.create(:confirmed_user) }

    before do
      sign_in_and_visit_students_as user
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

  context "as an admin user" do
    let(:admin) { FactoryGirl.create(:admin_user) }

    before do
      sign_in_and_visit_students_as admin
    end

    scenario "admin users don't have a link to contact students" do
      page.should_not have_content("Contact")
    end
  end
end
