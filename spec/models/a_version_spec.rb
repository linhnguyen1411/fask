require 'rails_helper'

RSpec.describe AVersion, type: :model do
  let!(:user) { FactoryGirl.create :user }
  let(:topic){FactoryGirl.create :topic}
  let!(:post) do
    FactoryGirl.create :post, user_id: user.id, topic_id: topic.id, count_view: 3,
      created_at: DateTime.new(2016, 01, 01)
  end

  let!(:a_version_x) do
    FactoryGirl.create :a_version, user_id: user.id, status: :accept,
      a_versionable_id: post.id, a_versionable_type: post.class.name
  end

  let!(:a_version_y) do
    FactoryGirl.create :a_version,
      user_id: user.id, status: :reject, a_versionable_id: post.id,
      a_versionable_type: post.class.name
  end
  let(:a_version_z) do
    FactoryGirl.create :a_version,
      user_id: user.id, status: :reject, a_versionable_id: post.id,
      a_versionable_type: post.class.name
  end

  context "association" do
    it{ is_expected.to have_many :activities }
    it{ is_expected.to belong_to :user }
    it{ is_expected.to belong_to :a_versionable }
  end

  context "a version scope" do
    it "get all version" do
      expect(AVersion.get_version(post.id,post.class.name)).to eq([a_version_x, a_version_y])
    end

    it "get version not reject" do
      expect(AVersion.get_version_not_reject).to eq([a_version_x])
    end

    it "get version accept" do
      expect(AVersion.get_version_accept).to eq([a_version_x])
    end
  end

  context "after action" do
    it "after update" do
      activity_count  = Activity.count
      a_version_x.update_attributes status: :reject
      expect(Activity.count).to eq(activity_count + 1)
    end

    it "after create" do
      activity_count  = Activity.count
      create_version = a_version_z
      expect(Activity.count).to eq(activity_count + 1)
    end
  end

end
