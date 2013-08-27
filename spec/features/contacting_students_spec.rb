require 'spec_helper'

feature "Connecting with students" do
  let!(:student) { FactoryGirl.create(:student_user) }

  context "as a professional user" do
    let(:professional) { FactoryGirl.create(:professional_user) }

    before do
      sign_in_and_visit_students_as professional
      click_button "Connect"
    end

    scenario "requesting connection with a particular student", js: true do
      page.current_path.should == students_path
      page.should have_content("You successfully requested connection with #{student.profile.name}.")
    end

    scenario "professional users see which students they have requested connection with" do
      within "#students tbody" do
        page.should have_content("Pending")
      end
    end

    scenario "users see when their connection request is accepted" do
    end
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
