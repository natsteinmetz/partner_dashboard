require 'spec_helper'

def should_have_students(*students)
  students.each do |student|
    page.should have_content(student.name)
    page.should have_content(student.skills)
  end
end

feature "Viewing students" do
  let!(:student_albert) { FactoryGirl.create(:student,
                                             name: "Albert Einstein",
                                             skills: "relativity") }
  let!(:student_werner) { FactoryGirl.create(:student,
                                             name: "Werner Heisenberg",
                                             skills: "quantum mechanics") }

  context "as a normal user" do
    before do
      user = FactoryGirl.create(:confirmed_user)
      sign_in_and_visit_students_as user
    end

    scenario "viewing students on students index" do
      should_have_students student_albert, student_werner
    end

    scenario "only showing students with a particular skill", :js => true do
      fill_in "student-filter", with: student_werner.skills
      page.should have_content student_werner.name
      page.should_not have_content student_albert.name
    end
  end

  context "as an admin" do
    before do
      admin_user = FactoryGirl.create(:admin_user)
      sign_in_and_visit_students_as admin_user
    end

    scenario "viewing students on students index" do
      should_have_students student_albert, student_werner
    end
  end
end
