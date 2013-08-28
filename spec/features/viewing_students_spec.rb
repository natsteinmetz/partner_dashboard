require 'spec_helper'

def should_have_students(*students)
  students.each do |student|
    page.should have_content(student.profile.name)
    page.should have_content(student.skills)
  end
end

# Find the table row for a student
def within_row_for(student, &block)
  row_xpath = [
    "//tr/td[@class='name' ",                       # find the cell with class="name"
    "and contains(., '#{student.profile.name}')]",  # and contains the text "Albert Einstein"
    "/..",                                          # find the parent
  ].join

  within(:xpath, row_xpath, &block)
end

# Matches a table cell with the class="for-hire" with an icon-ok inside it
FOR_HIRE_ICON_XPATH = [
  "td[@class='for-hire']",               # for a cell with class="for-hire"
  "/i[contains(@class, 'icon-ok')]"      # and an icon with class="icon-ok"
].join

feature "Viewing students" do
  let!(:student) { FactoryGirl.create(:student_user_with_courses) }
  let!(:student_2) { FactoryGirl.create(:student_user_with_courses) }

  before do
    student.profile = FactoryGirl.create(:profile,
                          for_hire: true,
                          skills: "C, Java, Rails")
    student.save
    student_2.profile = FactoryGirl.create(:profile,
                          skills: "Ruby, Erlang, Pascal")
    student2.save
  end

  context "as a professional user" do
    before do
      user = FactoryGirl.create(:professional_user)
      sign_in_and_visit_students_as user
    end

    scenario "can view all students on students index" do
      should_have_students student, student_2
    end

    scenario "can filter and only show students with a particular skill", :js => true do
      find("#skills-filter-show").click
      find(:css, "#skills-filter input").set(student_werner.skills)
      page.should have_content student_werner.profile.name
      page.should_not have_content student_albert.profile.name
    end

    scenario "can show which students are for hire and which are not" do
      within_row_for student_albert do
        page.should have_xpath(FOR_HIRE_ICON_XPATH)
      end

      within_row_for student_werner do
        page.should_not have_xpath(FOR_HIRE_ICON_XPATH)
      end
    end

    scenario "can see see each students' courses" do
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

  context "as a student" do
    before do
      albert_user = FactoryGirl.create(:student_user, email: student_albert.email, student_id: student_albert.id)
      sign_in_as! albert_user
    end

    scenario "can view own student profile" do
      page.should have_content("Albert")
      page.should have_content(student_albert.email)
    end

    scenario "can view other student's profiles but not personal contact information" do
      click_link "Courses"
      click_link student_werner.courses[0].title
      page.should have_content("Werner Heisenberg")
      click_link "Werner Heisenberg"
      page.should_not have_content student_werner.email
      page.should_not have_content student_werner.phone_number
    end
  end
end
