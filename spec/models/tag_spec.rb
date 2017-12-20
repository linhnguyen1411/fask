require "rails_helper"

RSpec.describe Tag, type: :model do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let(:user) { FactoryGirl.create :user, work_space_id: work_space.id }
  let(:topic){FactoryGirl.create :knowledge_topic}
  let!(:post) do
    FactoryGirl.create :post, work_space: work_space, user: user, topic: topic
  end
  let!(:tag) {FactoryGirl.create :tag}

  context "association" do
    it{expect have_and_belong_to_many :posts}
  end

  context ".top_tags" do
    let(:tag) {FactoryGirl.create :tag}

    it "don't have posts" do
      expect(Tag.top_tags.length).to eq 0
    end

    it "have posts" do
      FactoryGirl.create :posts_tag, post_id: post.id, tag_id: tag.id
      expect(Tag.top_tags.length).to be > 0
    end
  end
end
