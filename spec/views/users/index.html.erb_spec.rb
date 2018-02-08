require "rails_helper"

RSpec.describe "users/index.html.erb", type: :view do
  let(:work_space) { FactoryGirl.create :work_space}
  let!(:users) { FactoryGirl.create_list :user, 5, work_space_id: work_space.id }

  it "show index page" do
    assign :users, User.page(1).per(Settings.paginate_users)

    render
    expect(subject).to render_template('users/_user')
  end
end
