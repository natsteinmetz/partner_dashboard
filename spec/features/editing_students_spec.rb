require "spec_helper"

feature "editing student details" do
  before do
    @student = FactoryGirl.create(:student_user)
    @student.profile = FactoryGirl.create(:profile)
    @student.save
  end

  context "as a student" do
    before do
      sign_in_as!(@student)
      click_link "My Profile"
    end

    scenario "can edit own information" do
      page.should have_content(@student.email)
      click_link "Edit Profile"
      fill_in "First name", with: "Lady Gaga"
      fill_in "Last name", with: "the Great"
      click_button "Update Profile"
      page.should have_content "Lady Gaga the Great"
    end

    scenario "cannot edit information for other students" do
      course = FactoryGirl.create(:course)
      student_2 = FactoryGirl.create(:student_user)
      student_2.profile = FactoryGirl.create(:profile)
      student_2.save
      course.users << student_2
      course.users << @student

      click_link "Courses"
      page.should have_content(course.title)
      click_link course.title
      click_link student_2.profile.name
      page.should have_content(student_2.profile.name)
      page.should_not have_content "Edit Profile"
    end
  end

  context "as a professional" do
    scenario "cannot edit student profile info" do
      professional = FactoryGirl.create(:professional_user)
      sign_in_as!(professional)
      click_link "Students"
      click_link @student.profile.name
      page.should_not have_content("Edit Profile")
    end
  end

  context "as an admin" do
    scenario "can edit any profile info" do
      admin = FactoryGirl.create(:admin_user)
      sign_in_as!(admin)
      click_link "Students"
      click_link @student.profile.name
      page.should have_content("Edit Profile")
      click_link "Edit Profile"
      summary = "A person who is known for leaping tall buildings in a single bound."
      fill_in "Summary", with: summary
      click_button "Update Profile"
      page.should have_content(summary)
    end
  end
end
