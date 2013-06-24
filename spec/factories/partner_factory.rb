FactoryGirl.define do
  factory :partner do
    kinds = ["Big Co", "Startup", "Hiring Agency"]
    sequence(:name) {|n| "Company#{n}"}
    kind { kinds.sample }

    factory :partner_with_professional do
      after(:create) do |partner|
        professional = create(:professional)
        #Need to define a helper method for below statement
        professional.update_attribute(:email, "#{professional.name.emailize}@#{partner.name.emailize}.com")
        professional.employments.build(partner_id: partner.id, role: "Contact")
        professional.save
      end
    end
  end
end