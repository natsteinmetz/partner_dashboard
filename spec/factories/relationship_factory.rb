FactoryGirl.define do
  factory :relationship do
    factory :pending_relationship do
      partner
      student
      connected false
    end
  end
end