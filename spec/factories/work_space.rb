FactoryGirl.define do
  factory :work_space do
    name {Faker::Name.name}
    area {Faker::Address.city}
    image {Faker::Lorem.sentence(3)}
    description {Faker::LoremPixel.image}
  end
end
