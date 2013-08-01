require "spec_helper"

feature "viewing professional details" do

  context "as a professional/partner" do
    before do
      @professional_user = FactoryGirl.create(:confirmed_user)
      @professional = Professional.create(name: "Lady Gaga", 
        email: professional_user.email, phone_number: Faker::phone_number)
      @partner = FactoryGirl.create(:partner)
      professional.employments.build(partner_id: @partner.id, role: "Contact")
      professional.save

      sign_in_as!(professional_user)
      click_link "My Company"
    end

    scenario "can view own contact information" do
      click_link @professional.name
      page.should have_content(@professional.email)
      page.should have_content(@professional.phone_number)
    end

    scenario "can view contact information for professionals in own company" do
      professional_two = Professional.create(name: "Captain Crunch",
        email: "captain.crunch@yum.me", phone_number: Faker::phone_number)
      professional.employments.build(partner_id: @partner.id, role: "Contact")
      click_link professional_two
      page.should have_content(professional_two.email)
    end
  end

  context "as a student" do
    scenario "can view contact info for connected professional"
    scenario "cannot view contact info for non-connected professional"
  end
end
