FactoryGirl.define do
  factory :work_space do
    name {Faker::Lorem.words(3)}
    area {Faker::Address.city}
    image {Faker::LoremPixel.image}
    description {Faker::Lorem.sentence(3)}
  end
end
