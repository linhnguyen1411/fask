class CategoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :load_category

  def show
    @posts = Post.post_by_topic(Settings.topic.feedback).post_of_category(@category)
      .page(params[:page]).per Settings.paginate_default
  end

  private

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
