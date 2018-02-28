require "rails_helper"

RSpec.describe CategoriesController, type: :controller do

  let(:work_space) { FactoryGirl.create :work_space}
  let(:user){FactoryGirl.create :user, work_space: work_space}
  let(:user_eo){FactoryGirl.create :user, work_space: work_space, position: "Event Officer"}
  let(:topic){FactoryGirl.create :feedback_topic, status: 1}
  let!(:categories) {FactoryGirl.create_list :category, 5}
  let(:posts) do
    FactoryGirl.create_list :post, 5, work_space: work_space, user: user, topic: topic, category_id: categories.first.id
  end

  describe "#index" do
    context "Index success" do
      before do
        sign_in user_eo
        get :index, xhr: true
      end

      it "asigns @categories" do
        expect(assigns(:categories)).to eq Category.newest.page(Settings.one_page).per Settings.paginate_categories
      end
    end
  end

  describe "#show" do
    context "Show success" do
      before do
        sign_in user_eo
        get :show, params: {id: categories.first},xhr: true
      end

      it "asigns @category" do
        expect(assigns(:category)).to eq categories.first
      end
      it "asigns @posts" do
        expect(assigns(:posts)).to eq posts
      end
    end
  end

  describe "#new" do
    context "New success" do
      before do
        sign_in user_eo
        get :new, xhr: true
      end

      it "asigns @category" do
        expect(assigns(:category)) == Category.new
      end
    end
  end

  describe "#create" do
    context "Create success" do
      before do
        sign_in user_eo
        post :create, params: {category: {name: "new name"}}, xhr: true
      end

      it "asigns @category" do
        expect(assigns(:category).name).to eq "new name"
      end

      it "asigns @categories" do
        expect(assigns(:categories)).to eq Category.newest.page(Settings.one_page).per Settings.paginate_categories
      end
    end

    context "Create failure" do
      before do
        sign_in user
        post :create, params: {category: {name: "new name"}}, xhr: true
      end

      it "asigns @success" do
        expect(assigns(:success)).to eq nil
      end
    end
  end

  describe "#edit" do
    context "Edit success" do
      before do
        sign_in user_eo
        get :edit, params: {id: categories.first}, xhr: true
      end

      it "asigns @category" do
        expect(assigns(:category)).to eq categories.first
      end
    end
  end

  describe "#update" do
    context "Update success" do
      before do
        sign_in user_eo
        post :update, params: {id: categories.first, category: {name: "new name"}}, xhr: true
      end

      it "asigns @category" do
        expect(assigns(:category).name).to eq "new name"
      end
    end

    context "Update failure" do
      before do
        sign_in user_eo
        post :update, params: {id: 8888, category: {name: "new name"}}, xhr: true
      end

      it "asigns @category" do
        expect(assigns(:category)).to eq nil
      end
    end
  end

  describe "#delete" do
    context "Delete success" do
      before do
        sign_in user_eo
        post :destroy, params: {id: categories.first}, xhr: true
      end

      it "asigns @success" do
        expect(assigns(:success)).to eq categories.first
      end

      it "asigns @categories" do
        expect(assigns(:categories)).to eq Category.newest.page(Settings.one_page).per Settings.paginate_categories
      end
    end
  end
end
