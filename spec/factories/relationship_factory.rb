FactoryGirl.define do
  factory :relationship do
    factory :pending_relationship do
      partner
      user
      connection_allowed false
    end
  end
end
