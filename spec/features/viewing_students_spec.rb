require 'spec_helper'

def should_have_students(*students)
  students.each do |student|
    page.should have_content(student.name)
    page.should have_content(student.skills)
  end
end

# Find the table row for a student
def within_row_for(student, &block)
  row_xpath = [
    "//tr/td[@class='name' ",               # find the cell with class="name"
    "and contains(., '#{student.name}')]",  # and contains the text "Albert Einstein"
    "/..",                                  # find the parent
  ].join

  within(:xpath, row_xpath, &block)
end

# Matches a table cell with the class="for-hire" with an icon-ok inside it
FOR_HIRE_ICON_XPATH = [
  "td[@class='for-hire']",               # for a cell with class="for-hire"
  "/i[contains(@class, 'icon-ok')]"      # and an icon with class="icon-ok"
].join

feature "Viewing students" do
  let!(:student_albert) { FactoryGirl.create(:student,
                                             name: "Albert Einstein",
                                             skills: "relativity",
                                             for_hire: true) }
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

    scenario "showing which students are for hire" do
      within_row_for student_albert do
        page.should have_xpath(FOR_HIRE_ICON_XPATH)
      end

      within_row_for student_werner do
        page.should_not have_xpath(FOR_HIRE_ICON_XPATH)
      end
    end

    scenario "showing each students' courses" do
      within_row_for student_albert do
        student_albert.courses.each do |course|
          page.should have_content(course.title)
        end
      end
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
