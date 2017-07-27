FactoryGirl.define do
  factory :company do
    name {Faker::Name.name}
    parent_id 0
  end
end
