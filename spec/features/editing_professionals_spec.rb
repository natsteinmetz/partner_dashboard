require "spec_helper"

feature "editing professional details" do
  before do
    @professional_user = FactoryGirl.create(:confirmed_user)
    @professional = Professional.create(name: "Lady Gaga",
      email: @professional_user.email, phone_number: Faker::PhoneNumber.phone_number)
    @partner = FactoryGirl.create(:partner)
    @professional.employments.build(partner_id: @partner.id, role: "Contact")
    @professional.save

  end

  context "as a professional/partner" do
    before do
      sign_in_as!(@professional_user)
      click_link "Company"
    end

    scenario "can edit own information" do
      click_link @professional.name
      page.should have_content(@professional.email)
      page.should have_content(@professional.phone_number)
      click_link "Edit"
      fill_in "Name", with: "Lady Gaga the Great"
      click_link "Submit"
      page.should have_content "Lady Gaga the Great"
    end

    scenario "cannot edit information for other professionals in own company" do
      professional_two = Professional.create(name: "Captain Crunch",
        email: "captain.crunch@yum.me", phone_number: Faker::PhoneNumber.phone_number)
      professional_two.employments.build(partner_id: @partner.id, role: "Contact")
      click_link professional_two.name
      page.should have_content(professional_two.email)
      page.should_not have_content "Edit"
    end
  end

  context "as a student" do
    scenario "cannot edit profile info" do
      student = FactoryGirl.create(:student)
      student_user = FactoryGirl.create(:student_user, email: student.email, student_id: student.id)
      sign_in_as!(student_user)
      click_link "Partners"
      page.should_not have_content("Edit")
      page.should have_content(@professional.name)
      click_link @professional.name
      page.should_not have_content("Edit")
    end
  end

  context "as an admin" do
    scenario "can edit any profile info" do
      admin = FactoryGirl.create(:admin_user)
      click_link "Partners"
      click_link "Partner Index"
      click_link @partner.name
      page.should have_content(@partner.about)
      page.should have_content("Edit")
      click_link "Edit"
      fill_in "About", with: "This company has been included in The Best Places To Work in Seattle"
      click_link "Submit"
      page.should have_content("This company has been included in The Best Places To Work in Seattle")
    end
  end
end
