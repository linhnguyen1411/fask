FactoryGirl.define do
  factory :user do
    name {FFaker::Name.name}
    email {FFaker::Internet.email}
    password "Aa@123"
    password_confirmation "Aa@123"
  end
end
