class AnswersController < ApplicationController
  before_action :authenticate_user
  before_action :check_post, only: :create
  before_action :load_answer, only: :edit

  def create
    answer = current_user.answers.new answer_params
    if answer.save
      flash[:success] = t ".create_success"
    else
      flash[:danger] = t ".create_danger"
    end
    redirect_to post_path(@post.id)
  end

  def edit
    success = false
    if @answer.post.user == current_user
      if @answer.best_answer == false && @answer.update_attributes(best_answer: true)
        success = true
      end
    end
    respond_to do |format|
      format.json do
        render json: {type: success}
      end
    end
  end

  private

  def answer_params
    params.require(:answer).permit :content, :post_id, :parent_id
  end

  def check_post
    @post = Post.find_by id: params[:answer][:post_id]
    unless @post.present?
      flash[:danger] = t ".post_not_exist"
      redirect_to root_path
    end
  end

  def load_answer
    @answer = Answer.find_by id: params[:id]
    return if @answer
    flash[:danger] = t ".answer_not_exist"
    redirect_to root_path
  end
end
