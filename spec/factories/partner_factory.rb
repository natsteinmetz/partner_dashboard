FactoryGirl.define do
  factory :partner do
    kinds = ["Big Co", "Startup", "Hiring Agency"]
    sequence(:name) {|n| "Company#{n}"}
    kind { kinds.sample }
    about "This company saves the world on a daily basis.  You should totally work here!"
    website "http://www.#{:name}.com"  

    factory :partner_with_professional do
      after(:create) do |partner|
        professional = create(:professional_user)
        professional.employments.build(partner_id: partner.id, title: "VP of Awesomeness")
        professional.save
      end
    end
  end
end
