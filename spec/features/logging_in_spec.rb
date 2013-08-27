require "spec_helper"

feature "Log In" do
  scenario "admin can log in and land on Manage Connections page" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as!(admin)
    page.should have_content("Manage Connections")
    current_path == '/admin/relationships'
  end

  scenario "student can log in and land on Student Profile page" do
    user = FactoryGirl.create(:student_user)
    sign_in_as!(user)
    current_path == "/student/#{user.id}"
    page.should have_content(user.profile.name)
  end

  scenario "partner can log in and land on Dashboard page" do
    user = FactoryGirl.create(:professional_user)
    sign_in_as!(user)
    curent_path = "/dashboard"
    page.should have_content("Courses")
    page.should have_content("Students")
  end
end
