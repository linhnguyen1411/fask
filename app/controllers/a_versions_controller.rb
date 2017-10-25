class AVersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_posts, only: :create
  
  def index
    @post = Post.find_by id: params[:post_id]
    @version = AVersion.get_version(@post.id,@post.class.name).get_version_not_reject
  end
 
 def create
    version = AVersion.create(user_id: current_user.id,
      content: version_params[:content],a_versionable: @post)
    if version.save
      respond_to do |format|
        format.html do
          redirect_to post_path @post
        end
        format.js  
      end
    end
  end
 
  def update
    accept_version = AVersion.get_version(params[:post_id],params[:type]).get_version_accept
    post = Post.find_by id: params[:post_id]
    accept_version = accept_version.first
    version = AVersion.find_by id: params[:id]
    success = false
    if params[:status] == "accept"
      if version.update_attributes status: :accept
        post.update_attributes content: version.content
        accept_version.update_attributes status: :improve if accept_version.present?
        success = true
      end
    else params[:status] == "reject"
      if version.update_attributes status: :reject
        success = true
      end
    end
    respond_to do |format|
      format.json do
        render json: {type: success}
      end
    end
  end
 
  def destroy
    
  end
  private
  def version_params
    params.require(:a_version).permit :content, :post_id
  end

  def load_posts
    @post = Post.find_by id: version_params[:post_id]
  end
end
