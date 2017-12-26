class Dashboard::FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_event_officer_user
  before_action :load_post, only: :update

  def index
    @feedbacks = Post.feedback_post.newest
      .page(params[:page]).per Settings.paginate_posts
  end

  def update
    @post.update_attributes feedback_params
    if @post.save
      @success = true
    else
      @success = false
    end
    respond_to do |format|
      format.js
    end
  end

  private
  def feedback_params
    params.require(:post).permit :status
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def check_event_officer_user
    return if User.position_allowed_answer_feedback.include?(current_user)
    flash[:danger] = t "feedback.error"
    redirect_to root_path
  end
end
