class PostsController < ApplicationController
  before_action :check_user, only: :create

  def index
   if params[:query].present?
     @posts = Post.search params[:query],  page: params[:page],
       per_page: Settings.paginate_default
   else
     @posts = Post.page(params[:page]).per Settings.paginate_default
   end
  end

  def new
    @post = Post.new
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

  private
  def qa_params
    params.require(:post).permit :topic_id, :title, :content
  end

  def feedback_params
    params.require(:post).permit :topic_id, :title, :content, :work_space_id
  end

  def confesstion_params
    params.require(:post).permit :topic_id, :title, :content
  end

  def check_user
    @post = Post.new feedback_params
    case
    when params[:post][:topic_id] == Settings.topic.q_a
      if current_user.present?
        @user = current_user
      else
        @user = User.find_by email: params[:user_email]
        unless @user.present? && @user.valid_password?(params[:user_password])
          flash[:danger] = t ".email_or_password_not_exist"
          render :new
        end
      end
    when params[:post][:topic_id] == Settings.topic.feedback
      if params[:anonymous] == Settings.anonymous
        @user = User.first
      else
        if current_user.present?
          @user = current_user
        else
          @user = User.find_by email: params[:user_email]
          unless @user.present? && @user.valid_password?(params[:user_password])
            flash[:danger] = t ".email_or_password_not_exist"
            render :new
          end
        end
      end
    else
      @user = User.first
    end
  end

  def create_post post_params
    post = Post.new post_params
    post.user_id = @user.id
    if post.save
      save_tags(post) if params[:tags].present?
      flash[:success] = t ".create_success"
      redirect_to root_path
    else
      flash[:danger] = t ".create_error"
      render :new
    end
  end

  def save_tags post
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

  def save_post_tags post, tag
    PostsTag.create post_id: post.id, tag_id: tag.id
  end
end
