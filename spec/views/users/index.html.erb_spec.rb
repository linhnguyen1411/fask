require "rails_helper"

RSpec.describe "users/index.html.erb", type: :view do
  let(:company) { FactoryGirl.create :company }
  let(:work_space) { FactoryGirl.create :work_space, company_id: company.id }
  let!(:users) { FactoryGirl.create_list :user, 5, work_space_id: work_space.id }

  it "show index page" do
    assign :users, User.page(1).per(Settings.paginate_users)

    render
    expect(subject).to render_template('users/_user')
  end
end
