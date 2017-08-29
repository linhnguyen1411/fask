class CommentsController < ApplicationController
  before_action :load_comment, only: [:update, :destroy]

  def create
    @object = find_object params[:comment][:object_type], params[:comment][:object_id]
    @comment = @object.comments.build comment_params
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          redirect_to post_path @object
        end
        format.js
      end
    end
  end

  def update
    success = false
    if @comment.user == current_user && @comment.update_attributes(content: params[:content])
      success = true
    end
    respond_to do |format|
      format.json do
        render json: {type: success, content: @comment.content}
      end
    end
  end

  def destroy
    success = false
    if @comment.user == current_user && @comment.destroy
      success = true
    end
    respond_to do |format|
      format.json do
        render json: {type: success}
      end
    end
  end

  private
  def comment_params
    params.require(:comment).permit :content
  end

  def find_object object_type, object_id
    if object_type == Settings.comment.object_type.post
      @object = Post.find_by id: object_id
    elsif object_type == Settings.comment.object_type.answer
      @object = Answer.find_by id: object_id
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end
end
