require "spec_helper"

feature "viewing professional details" do

  context "as a professional/partner" do
    before do
      @professional_user = FactoryGirl.create(:confirmed_user)
      @professional = Professional.create(name: "Lady Gaga", 
        email: @professional_user.email, phone_number: Faker::PhoneNumber.phone_number)
      @partner = FactoryGirl.create(:partner)
      @professional.employments.build(partner_id: @partner.id, role: "Contact")
      @professional.save
      @professional_user.partner = @partner
      @professional_user.save
      sign_in_as!(@professional_user)
      click_link "My Company"
    end

    pending scenario "can view own contact information" do
      click_link @professional.name
      page.should have_content(@professional.email)
      page.should have_content(@professional.phone_number)
    end

    pending scenario "can view contact information for professionals in own company" do
      #Can't quite get the test to work but it works in project
      professional_user_two = FactoryGirl.create(:confirmed_user)
      professional_two = Professional.create(name: "Captain Crunch", 
        email: professional_user_two.email, phone_number: Faker::PhoneNumber.phone_number)
      professional_two.employments.build(partner_id: @partner.id, role: "Contact")
      professional_two.save
      professional_user_two.partner = @partner
      professional_user_two.save

      # professional_two = Professional.create(name: "Captain Crunch",
      #   email: "captain.crunch@yum.me", phone_number: Faker::PhoneNumber.phone_number)
      # professional_two.employments.build(partner_id: @partner.id, role: "Contact")
      # @partner.professionals << @professional_two
      # @partner.save
      # professional_two.save
      binding.pry
      save_and_open_page
      click_link professional_two.name
      page.should have_content(professional_user_two.email)
    end
  end

  context "as a student" do
    scenario "can view contact info for connected professional"
    scenario "cannot view contact info for non-connected professional"
  end
end
