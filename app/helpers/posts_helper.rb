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
end
