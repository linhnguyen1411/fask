class AVersionsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_posts, only: :create
  before_action :check_user_owner, only: [:index, :update]
  before_action :load_accept_version, only: :update

  def index
    @version_of_post = AVersion.get_version_post_not_reject(@post.id, @post.class.name)
      .page(params[:page]).per Settings.paginate_default
    @current_accept_aversion = @post.a_versions.accept.first
  end

  def create
    version = AVersion.new(user_id: current_user.id,
      content: version_params[:content], a_versionable: @post)
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
    ActiveRecord::Base.transaction do
      @version = AVersion.find_by id: params[:id]
      if params[:a_version].present? && version_params[:content]
        @version.update_attributes content: version_params[:content]
        @type = Settings.edit
        respond_to do |format|
          format.js
        end
      else
        @type = Settings.update
        @success = false
        if params[:status] == Settings.version.accept
          if @version.update_attributes status: :accept
            @accept_version.update_attributes status: :improve if @accept_version.present?
            @success = true
          end
          @version_of_post = AVersion.get_version_post_not_reject(@post.id, @post.class.name)
            .page(params[:page]).per Settings.paginate_default
          respond_to do |format|
            format.js
          end
        else params[:status] == Settings.version.reject
          if @version.update_attributes status: :reject
            @success = true
          end
          respond_to do |format|
            format.json do
              render json: {type: @success, default_content: @post.content}
            end
          end
        end
      end
    end
  end

  def destroy
    @status = false
    version = AVersion.find_by id: params[:id]
    if version
      @version_id = version.id
      version.destroy
      @status = true
    else
      @version_id = params[:id]
      @status = false
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def version_params
    params.require(:a_version).permit :content, :post_id
  end

  def load_posts
    @post = Post.find_by id: version_params[:post_id]
    return if @post
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def check_user_owner
    if params[:post_id]
      @post = Post.find_by id: params[:post_id]
      redirect_to post_path @post.id if current_user.id != @post.user_id
    end
  end

  def load_accept_version
    @accept_version = AVersion.get_version(params[:post_id],
      params[:type]).accept.first
  end
end
