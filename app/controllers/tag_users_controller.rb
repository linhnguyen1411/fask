class TagUsersController < ApplicationController
  def index
    users = User.search(name_cont: params[:key]).result.not_user_hiddent
    respond_to do |format|
      format.json do
        render json: {data: users.map{|u|[u.id, u.name]}}
      end
    end
  end
end
