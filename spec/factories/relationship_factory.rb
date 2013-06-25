FactoryGirl.define do
  factory :relationship do
    factory :pending_relationship do
      partner
      student
      contact_allowed false
    end
  end
end