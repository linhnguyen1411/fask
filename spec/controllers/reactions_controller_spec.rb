require "rails_helper"

RSpec.describe ReactionsController, type: :controller do
  let(:user){FactoryGirl.create :user}
  let(:topic){FactoryGirl.create :topic}
  let!(:post_x) do
    FactoryGirl.create :post, user_id: user.id, topic_id: topic.id
  end
  let!(:answer) do
    FactoryGirl.create :answer, user_id: user.id, post_id: post_x.id
  end
  let("params_no_exists") do
    {
      model: Post.name,
      item_id: 0
    }
  end
  let("params_update_fail") do
    {
      model: Post.name,
      item_id: post_x.id,
      type: "xxx"
    }
  end
  let("params_post_success") do
    {
      model: Post.name,
      item_id: post_x.id,
      type: Settings.reaction_type.down
    }
  end
  let("params_answer_success") do
    {
      model: Answer.name,
      item_id: answer.id,
      type: Settings.reaction_type.like
    }
  end

  describe "POST #create" do
    before do
       sign_in user
    end

    context "when response not exists" do
      before {post :create, params: params_no_exists, xhr: true}
      let(:response_body) {{type: Settings.error}}
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end

    context "when reaction update fail" do
      before do
        allow_any_instance_of(Reaction).to receive(:update_attributes).and_return false
        post :create, params: params_update_fail, xhr: true
      end
      let(:response_body) {{type: Settings.error}}
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end

    context "when reaction post response success" do
      before {post :create, params: params_post_success, xhr: true}
      let(:response_body) {
        {
          type: Settings.success,
          data: post_x.reactions.upvote.size - post_x.reactions.downvote.size
        }
      }
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end

    context "when reaction answer response success" do
      before {post :create, params: params_answer_success, xhr: true}
      let(:response_body) {
        {
          type: Settings.success,
          data: [
            answer.reactions.like.size,
            answer.reactions.dislike.size,
            answer.reactions.heart.size
          ]
        }
      }
      it {expect(subject.status).to eq 200}
      it {expect(subject.response_body).to eq [response_body.to_json]}
    end
  end
end
