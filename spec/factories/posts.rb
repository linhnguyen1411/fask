FactoryGirl.define do
  factory :post do
    title {Faker::Name.name}
    content {Faker::Name.name}
    view_counts 0
  end
end
