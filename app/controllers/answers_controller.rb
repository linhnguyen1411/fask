class AnswersController < ApplicationController
  before_action :authenticate_user
  before_action :check_post, only: :create
  before_action :load_answer, only: [:update, :edit, :destroy]
  before_action :check_onwer_answer, only: [:update, :destroy]

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
    if params[:edit_content].nil?
      if @answer.post.user == current_user
        if @answer.best_answer == false && @answer.update_attributes(best_answer: true)
          success = true
        end
      end
    end
    respond_to do |format|
      format.js
      format.json do
        render json: {type: success}
      end
    end
  end

  def update
    if @answer.update_attributes answer_params
      @new_answer = Answer.new
      respond_to do |format|
        format.js
      end
    else
      flash[:danger] = t ".update_error"
      redirect_to @answer.post
    end
  end

  def destroy
    success = false
    if @answer.destroy
      success = true
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

  def check_onwer_answer
    return if @answer.user == current_user
    flash[:danger] = t ".wrong_user"
    redirect_to root_path
  end

  def load_answer
    @answer = Answer.find_by id: params[:id]
    return if @answer
    flash[:danger] = t ".answer_not_exist"
    redirect_to root_path
  end
end
