class ReactionsController < ApplicationController
  before_action :load_item, only: :create

  def create
    @reaction = Reaction.find_or_create_by reactiontable_type: @item.class.name,
      reactiontable_id: @item.id, user_id: current_user.id
    resufl = {}
    if @reaction.update_attributes target_type: params[:type]
      resufl = {type: Settings.success, data: load_resufl(@item)}
    else
      resufl = {type: Settings.error}
    end
    respond_to do |format|
      format.json do
        render json: resufl
      end
    end
  end

  private

  def load_item
    case
    when params[:model] == Post.name
      @item = Post.find_by id: params[:item_id]
    when params[:model] == Answer.name
      @item = Answer.find_by id: params[:item_id]
    when params[:model] == Comment.name
      @item = Comment.find_by id: params[:item_id]
    end
    unless @item.present?
      respond_to do |format|
        format.json do
          render json: {type: Settings.error}
        end
      end
    end
  end

  def load_resufl item
    if item.class.name == Post.name
      return item.reactions.upvote.size - item.reactions.downvote.size
    else
      return [item.reactions.like.size, item.reactions.dislike.size, item.reactions.heart.size]
    end
  end
end
