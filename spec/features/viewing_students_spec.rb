require 'spec_helper'

def should_have_students(*students)
  students.each do |student|
    page.should have_content(student.profile.name)
    page.should have_content(student.profile.skills)
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
    student_2.save
  end

  context "as a professional user" do
    before do
      @user = FactoryGirl.create(:professional_user)
      sign_in_and_visit_students_as @user
    end

    scenario "can view all students on students index" do
      should_have_students student, student_2
    end

    scenario "can filter and only show students with a particular skill", :js => true do
      find("#skills-filter-show").click
      find(:css, "#skills-filter input").set(student.profile.skills)
      page.should have_content student.profile.name
      page.should_not have_content student_2.profile.name
    end

    scenario "can show which students are for hire and which are not" do
      within_row_for student do
        page.should have_xpath(FOR_HIRE_ICON_XPATH)
      end

      within_row_for student_2 do
        page.should_not have_xpath(FOR_HIRE_ICON_XPATH)
      end
    end

    scenario "can see see each students' courses" do
      within_row_for student do
        student.courses.each do |course|
          page.should have_content(course.title)
        end
      end
    end

    scenario "cannot view student contact info for non-connected students" do
      click_link student.profile.name
      page.should have_content(student.profile.name)
      page.should_not have_content(student.email)
      page.should_not have_content(student.profile.phone_number)
    end

    scenario "can view student contact info for connected students" do
      @user.partner = FactoryGirl.create(:partner)
      @user.save
      @user.partner.relationships.create(partner_id: @user.id, user_id: student.id, connection_allowed: true)
      assert @user.connected? student

      click_link student.profile.name
      page.should have_content(student.profile.name)
      page.should have_content(student.email)
      page.should have_content(student.profile.phone_number)
    end
  end

  context "as an admin" do
    before do
      admin_user = FactoryGirl.create(:admin_user)
      sign_in_and_visit_students_as admin_user
    end

    scenario "can view student profile with all details" do
      page.should have_content(student.profile.name)
      click_link student.profile.name
      page.should have_content(student.email)
      page.should have_content(student.profile.phone_number)
    end

    scenario "can view all students on students index" do
      should_have_students student, student_2
    end
  end

  context "as a student" do
    before do
      sign_in_as! student
    end

    scenario "can view own student profile" do
      click_link "My Profile"
      page.should have_content(student.profile.name)
      page.should have_content(student.email)
    end

    scenario "can view other student's profiles but not personal contact information" do
      student_2.courses << student.courses[0]
      student_2.save
      click_link "Courses"
      click_link student.courses[0].title
      page.should have_content(student_2.profile.name)
      click_link student_2.profile.name
      page.should_not have_content student_2.email
      page.should_not have_content student_2.profile.phone_number
    end
  end
end
