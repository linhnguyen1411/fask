class PostsController < ApplicationController
  before_action :authenticate_user
  authorize_resource
  before_action :check_user, only: :create
  before_action :load_post, except: [:new, :index, :create]
  before_action :plus_count_view, only: :show
  before_action :load_popular_tags, only: [:new, :edit]
  before_action :see_notification, only: :show

  def index
    if params[:query].present?
      @posts = Post.accept.search params[:query], operator: "or",
        page: params[:page], per_page: Settings.paginate_default
    else
      @posts = Post.accept.page(params[:page]).per Settings.paginate_default
    end
  end

  def new
    @support = Supports::PostSupport.new
    @post = case params[:topic_id]
    when Settings.topic.q_a
      Post.new topic_id: Settings.topic.q_a_number
    when Settings.topic.feedback
      Post.new topic_id: Settings.topic.feedback_number, work_space_id: current_user.work_space_id
    when Settings.topic.confesstion
      Post.new topic_id: Settings.topic.confesstion_number
    else
      Post.new
    end
  end

  def show
    check_user_owner_feedback
    @post_extension = Supports::PostSupport.new @post, show_post_params.to_h
    @answer = Answer.new
    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    case
    when params[:post][:topic_id] == Settings.topic.q_a
      create_post qa_params
    when params[:post][:topic_id] == Settings.topic.feedback
      create_post feedback_params
    when params[:post][:topic_id] == Settings.topic.confesstion
      create_post confesstion_params
    else
      flash[:danger] = t ".topic_not_exist"
      render :new
    end
  end

  def edit
    @support = Supports::PostSupport.new @post
  end

  def update
    if check_owner_post || @post.topic_id == Settings.topic.feedback_number &&
      User.position_allowed_answer_feedback.include?(current_user)
      @post.tags.destroy_all
      save_tags(@post) if params[:tags].present?
      if @post.update_attributes update_post_params
        flash[:success] = t ".success"
      else
        flash[:danger] = t ".error"
      end
    else
      flash[:danger] = t ".error"
    end
    respond_to do |format|
      format.html { redirect_to post_path(@post.id) }
      format.js
    end
  end

  def destroy
    success = false
    if @post.user == current_user && @post.destroy
      success = true
    end
    respond_to do |fomat|
      fomat.json { render json: {type: success} }
    end
  end

  private
  def qa_params
    params.require(:post).permit :topic_id, :title, :content
  end

  def feedback_params
    params.require(:post).permit :topic_id, :title, :content, :work_space_id, :category_id, :status
  end

  def confesstion_params
    params.require(:post).permit :topic_id, :title, :content
  end

  def update_post_params
    params.require(:post).permit :title, :content, :category_id, :status
  end

  def show_post_params
    params.permit :comment_page, :view_more_time
  end

  def check_user
    case
    when params[:post][:topic_id] == Settings.topic.confesstion
      @user = User.first
    when params[:post][:topic_id] == Settings.topic.feedback
      if params[:anonymous] == Settings.anonymous
        @user = User.first
      else
        @user = current_user
      end
    else
      @user = current_user
    end
  end

  def create_post post_params
    post = Post.new post_params
    post.user_id = @user.id
    if post.topic_name == Settings.feedback
      post.status = Settings.post.status.waiting
    end
    authorize! :create, post
    if post.save
      check_post_saved post
    else
      flash[:danger] = t ".create_error"
      redirect_to new_post_path
    end
  end

  def check_post_saved post
    save_tags(post) if params[:tags].present?
    if post.topic_name == Settings.feedback
      if post.user_id == Settings.anonymous_number
        redirect_to root_path
      else
        redirect_to post_path(post.id)
      end
      flash[:success] = t "posts.status.feedback_info"
    else
      flash[:success] = t ".create_success"
      redirect_to post_path(post.id)
    end
  end

  def save_tags post
    Tag.transaction do
      params[:tags].split(",").each do |item|
        tag = Tag.find_by name: item
        if tag.present?
          tag.update_attribute :used_count, tag.used_count + Settings.plus_one
          save_post_tags post, tag
        else
          tag = Tag.create name: item
          save_post_tags post, tag
        end
      end
    end
  end

  def save_post_tags post, tag
    PostsTag.create post_id: post.id, tag_id: tag.id
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post.present? && @post.topic.status == true
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def plus_count_view
    @post.update_attributes count_view: @post.count_view + 1
  end

  def load_popular_tags
    @popular_tags = Tag.top_tags.limit Settings.limit_suggest_tag
  end

  def check_user_owner_feedback
    if @post.topic_id == Settings.topic.feedback_number && !@post.accept?
      return if @post.user_id == current_user.id && current_user.id != Settings.anonymous_number
      flash[:danger] = t ".not_found"
      redirect_to root_path
    end
  end

  def check_owner_post
    return true if @post.user == current_user
  end
end
