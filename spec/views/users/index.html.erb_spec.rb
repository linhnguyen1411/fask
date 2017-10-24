require "rails_helper"

RSpec.describe "users/index.html.erb", type: :view do
  let!(:users) {FactoryGirl.create_list :user, 5}

  it "show index page" do
    assign :users, User.page(1).per(Settings.paginate_users)

    render
    expect(subject).to render_template('users/_user')
  end
end
