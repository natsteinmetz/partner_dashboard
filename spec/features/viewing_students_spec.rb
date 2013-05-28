require 'spec_helper'

feature "Viewing students" do
  let!(:student_albert) { FactoryGirl.create(:student,
                                             name: "Albert Einstein",
                                             skills: "relativity") }
  let!(:student_werner) { FactoryGirl.create(:student,
                                             name: "Werner Heisenberg",
                                             skills: "quantum mechanics") }

  before do
    user = FactoryGirl.create(:user)
    sign_in_as!(user)
  end

  scenario "viewing students on students index" do
    visit "/"

    page.should have_content(student_albert.name)
    page.should have_content(student_albert.skills)

    page.should have_content(student_werner.name)
    page.should have_content(student_werner.skills)
  end
end
