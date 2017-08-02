FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    avatar {Faker::Avatar.image}
    position {"Developer"}
    code {Faker::Code.asin}
    password {"Aa@123"}
  end
end
