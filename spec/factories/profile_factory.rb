FactoryGirl.define do
  factory :profile do
    first_names = ["Larry", "Lauren", "Michael", "Michelle"]
    last_names = ["Laurence", "Michaels", "Mueller", "Smith", "Danger"]

    first_name { first_names.sample }
    last_name { last_names.sample }
    phone_number "555-555-5555"
  end
end
