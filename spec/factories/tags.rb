FactoryGirl.define do
  factory :tag do
    name {Faker::Lorem.words(2)}
  end
end
