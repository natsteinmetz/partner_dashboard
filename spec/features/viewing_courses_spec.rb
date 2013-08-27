require 'spec_helper'

feature "Viewing courses" do
  let!(:course_one) { FactoryGirl.create(:course, title: "Rails September 2013") }
  let!(:course_two) { FactoryGirl.create(:course, title: "Javascript March 2014") }

  context "as a normal(partner/professional) user" do
    before do
      user = FactoryGirl.create(:confirmed_user)
      sign_in_as!(user)
      visit "/"
      click_link "Courses"
    end

    scenario "can view all courses on courses index" do
      page.should have_content(course_one.title)
      page.should have_content(course_two.title)
    end

    scenario "can view details of a course with students and the ability to connect with them"
  end

  context "as a student user" do
    before do
      student = FactoryGirl.create(:student_user)
      sign_in_as!(student)
      visit '/'
      click_link "Courses"
    end

    scenario "can view all courses on courses index" do
      page.should have_content(course_one.title)
      page.should have_content(course_two.title)
    end

    scenario "can view details of a course and all students who took the course but cannot connect" do
      click_link course_one.title
      page.should_not have_content("Status")
    end
  end
end
