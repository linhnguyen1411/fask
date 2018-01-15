class CommentsController < ApplicationController
  before_action :authenticate_user
  before_action :load_comment, only: [:update, :destroy]

  def create
    find_object params[:comment][:object_type], params[:comment][:object_id]
    if @permit
      @comment = @object.comments.build comment_params
      @comment.user_id = current_user.id
      if @comment.save
        respond_to do |format|
          format.html { redirect_to post_path @object }
          format.js
        end
        SendEmailNotificationJob.set(wait: Settings.time_send_mail.seconds)
          .perform_later(@object.user, current_user, @object) if email_setting
      end
    else
      redirect_to post_path @object
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
      @permit = (@object.topic_id != Settings.topic.feedback_number)
    elsif object_type == Settings.comment.object_type.answer
      @object = Answer.find_by id: object_id
      @permit = (@object.post.topic_id != Settings.topic.feedback_number)
    end
  end

  def load_comment
    @comment = Comment.find_by id: params[:id]
    return if @comment
    flash[:danger] = t ".not_found"
    redirect_to root_path
  end

  def email_setting
    @object.class.name == Settings.post.model_name && current_user != @object.user &&
      @object.user.email_settings[:comment_post] == Settings.notification_setting.comment_post_number
  end
end
