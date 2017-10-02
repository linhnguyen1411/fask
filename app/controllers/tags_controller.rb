class TagsController < ApplicationController
  before_action :load_tag, only: :show

  def index
    @tags = Tag.top_tags.page(params[:page]).per Settings.paginate_tags
  end

  def show
    @tag_popular = Tag.top_tags
    @posts_tag = Post.by_tags(params[:id]).page(params[:page])
      .per Settings.paginate_default
  end

  private
  def load_tag
    @tag = Tag.find_by id: params[:id]
    return if @tag
      redirect_to :back
      flash[:danger] = t "can_not_load"
  end
end
