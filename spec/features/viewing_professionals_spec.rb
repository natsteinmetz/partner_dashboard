require "spec_helper"

feature "viewing professional details" do
  let!(:professional) { FactoryGirl.create(:professional_user) }
  let!(:professional_two) { FactoryGirl.create(:professional_user) }
  let!(:partner) { FactoryGirl.create(:partner) }

  before do
    professional.profile = FactoryGirl.create(:profile)
    professional.partner = partner
    professional.save

    professional_two.partner = partner
    professional_two.profile = FactoryGirl.create(:profile)
    professional_two.save
  end

  context "as a professional user" do
    before do
      sign_in_as!(professional)
    end

    scenario "can view own contact information" do
      click_link "My Company"
      click_link professional.profile.name
      page.should have_content(professional.email)
      page.should have_content(professional.profile.phone_number)
    end

    scenario "can view contact information for professionals in own company" do
      click_link "My Company"

      click_link professional_two.profile.name
      page.should have_content(professional_two.profile.name)
      page.should have_content(professional_two.profile.phone_number)
      page.should have_content(professional_two.email)
    end

    scenario "cannot view other company partners" do
      page.should_not have_content("Partners")
    end
  end

  context "as a student" do
    before do
      @student = FactoryGirl.create(:student_user)
      sign_in_as!(@student)
      click_link "Partners"
      page.should have_content(partner.name)
      click_link partner.name

      page.should have_content(professional.profile.name)
      page.should have_content(professional_two.profile.name)
    end

    scenario "can view contact info for connected professional" do
      partner.students << @student
      partner.save
      click_link professional.profile.name
      page.should have_content(professional.email)
      page.should have_content(professional.profile.phone_number)
    end

    scenario "cannot view contact info for non-connected professional" do
      click_link professional.profile.name
      page.should_not have_content(professional.email)
      page.should_not have_content(professional.profile.phone_number)
    end

  end
end
