require "spec_helper"

feature "Log In" do
  scenario "admin can log in and land on Manage Connections page" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as!(admin)
    page.should have_content("Manage Connections")
    current_path == '/admin/relationships'
  end

  scenario "student can log in and land on Student Profile page" do
    student = FactoryGirl.create(:student)
    user = FactoryGirl.create(:student_user, student: student, email: student.email)
    sign_in_as!(user)
    current_path == "/student/#{user.student_id}"
    page.should have_content(user.student.name)
  end

  scenario "partner can log in and land on Dashboard page" do
    user = FactoryGirl.create(:confirmed_user)
    sign_in_as!(user)
    curent_path = "/dashboard"
    page.should have_content("Courses")
    page.should have_content("Students")
  end
end
