FactoryGirl.define do
  factory :answer do
    content {Faker::Name.name}
  end
end
