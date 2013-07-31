require 'spec_helper'

feature "Connecting with students" do
  let!(:student) { FactoryGirl.create(:student) }

  context "as a normal user" do
    let(:user) { FactoryGirl.create(:confirmed_user) }

    before do
      sign_in_and_visit_students_as user
      click_button "Connect"
    end

    scenario "requesting connection with a particular student", js: true do
      page.current_path.should == students_path
      page.should have_content("You successfully requested connection with #{student.name}.")
    end

    scenario "users see which students they have requested connection with" do
      within "#students tbody" do
        page.should have_content("Pending")
      end
    end

    scenario "users see when their connection request is accepted" 
  end

  context "as an admin user" do
    let(:admin) { FactoryGirl.create(:admin_user) }

    before do
      sign_in_and_visit_students_as admin
    end

    scenario "admin users don't have a link to connect with students" do
      within('#students') do
        page.should_not have_content("Connect")
      end
    end

    scenario "admin can approve connection" do
    end
  end
end
