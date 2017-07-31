FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    avatar {Faker::Avatar.image}
    position {"Developer"}
    code {Faker::Code.asin}
  end
end
