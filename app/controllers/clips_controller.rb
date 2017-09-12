class ClipsController < ApplicationController

  def create
    success = false
    @post = Post.find_by id: params[:post_id]
    if @post
      unless Clip.find_by(user_id: current_user.id, post_id: @post.id).present?
        if Clip.create user_id: current_user.id, post_id: @post.id
          success = true
        end
      end
      respond_to do |format|
      format.json do
        render json: {type: success}
      end
    end
    end
  end

  def destroy
    clip = Clip.find_by user_id: current_user.id, post_id: params[:id]
    if clip.destroy
      success = true
    else
      success = false
    end
    respond_to do |format|
      format.json do
        render json: {type: success}
      end
    end
  end
end
