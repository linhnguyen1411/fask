class TagsController < ApplicationController
  def index
    @tags = Tag.top_tags.page(params[:page]).per Settings.paginate_tags
  end
end
