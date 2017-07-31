FactoryGirl.define do
  factory :answer do
    content {Faker::Lorem.sentence(2)}
    best_answer {Faker::Boolean.boolean}
  end
end
