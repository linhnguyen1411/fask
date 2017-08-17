module PostsHelper
  def load_select_box_topic
    Topic.all.collect{|t| [t.name, t.id]}
  end

  def load_select_box_location
    WorkSpace.all.collect{|w| [w.name, w.id]}
  end

  def count_vote post
    post.reactions.upvote.size - post.reactions.downvote.size
  end

  def add_class_active_to_show_page type_input, type_sort, is_first_tab = false
    !type_input && is_first_tab || type_input && type_input == type_sort ? "active" : ""
  end

  def user_comment_recently_of_post post
    post.comments.first.user_name if post.comments.present?
  end

  def load_btn_correct_answer answer, post
    if current_user.present? && !answer.best_answer && current_user.id == post.user_id
      return link_to t(".correct_answer"), "javascript:", class: "btn btn-sm btn-default btn-hover-primary"
    end
  end

  def load_btn_reactions_answer answer, title, type
    case
    when type == Settings.reaction_type.like
      content = '<span class="count-like">' + "#{answer.reactions.like.size}" + '</span><i class="fa fa-thumbs-up"></i>'
    when type == Settings.reaction_type.dislike
      content = '<span class="count-dislike">' + "#{answer.reactions.dislike.size}" + '</span><i class="fa fa-thumbs-down"></i>'
    else
      content = '<span class="count-heart">' + "#{answer.reactions.heart.size}" + '</span><i class="fa fa-heartbeat"></i>'
    end
    if current_user.present?
      link_to "javascript:", class: "btn btn-sm btn-default btn-vote",
        data: {toggle: "tooltip", placement: "bottom", "original-title": title,
        model: Answer.name, type: type, id: answer.id } do
        raw content
      end
    else
      link_to "javascript:", class: "btn btn-sm btn-default btn-loggin-continue",
        data: {toggle: "tooltip", placement: "bottom", "original-title": title} do
        raw content
      end
    end
  end
end
