class TagsController < ApplicationController
  def index
    tags = Tag.search(name_cont: params[:key]).result.by_used_count
    respond_to do |format|
      format.json do
        render json: {data: tags.map(&:name)}
      end
    end
  end
end
