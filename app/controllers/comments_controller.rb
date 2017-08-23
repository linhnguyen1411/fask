class CommentsController < ApplicationController
  def create
    @object = find_object params[:comment][:object_type], params[:comment][:object_id]
    @comment = @object.comments.build comment_params
    @comment.user_id = current_user.id
    if @comment.save
      respond_to do |format|
        format.html do
          redirect_to post_path(post: @object)
        end
        format.js
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
end
