FactoryGirl.define do
  factory :a_version do
    content { Faker::Lorem.sentence(5) }
    status 1
  end
end
