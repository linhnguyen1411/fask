FactoryGirl.define do
  factory :topic do
    factory :knowledge_topic do
      id 1
      name {"Knowledge Q&A"}
    end
    factory :feedback_topic do
      id 2
      name {"Feedback"}
    end
    factory :confesstion_topic do
      id 3
      name {"Confesstion"}
    end
  end
end
