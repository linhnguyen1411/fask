class Dashboard::FeedbacksController < ApplicationController
  before_action :authenticate_user!
  before_action :check_event_officer_user
  before_action :load_post, only: [:update, :destroy]

  def index
    @feedback_support = Supports::FeedbackSupport.new(current_user, post_params.to_h)
    respond_to do |format|
      format.html
      format.js
      format.xlsx { response.headers['Content-Disposition'] = 'attachment; filename="all_feedbacks.xlsx"' }
    end
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

  def destroy
    @success =  @post.destroy
  end

  private
  def feedback_params
    params.require(:post).permit :status
  end

  def post_params
    params.permit :page, :category_id, :work_space_id, :status, :to_xlsx, :format
  end

  def load_post
    @post = Post.find_by id: params[:id]
    return if @post
    respond_to do |format|
      format.html{ redirect_to root_path }
      format.js{render}
    end
  end

  def check_event_officer_user
    return if User.position_allowed_answer_feedback.include?(current_user)
    flash[:danger] = t "feedback.error"
    redirect_to root_path
  end
end
