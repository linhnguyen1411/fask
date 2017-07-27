FactoryGirl.define do
  factory :user do
    name {Faker::Name.name}
    email {Faker::Internet.email}
    password "Aa@123"
    password_confirmation "Aa@123"
  end
end
