module PostsHelper
  def load_select_box_topic
    Topic.all.collect{|t| [t.name, t.id]}
  end

  def load_select_box_location
    WorkSpace.all.collect{|w| [w.name, w.id]}
  end

  def count_comment post
    post.comments.size
  end

  def count_vote post
    post.reactions.upvote.size - post.reactions.downvote.size
  end

  def count_version post
    post.a_versions.get_version_post_not_reject(post.id, post.class.name).size
  end

  def add_class_active_to_show_page type_input, type_sort, is_first_tab = false
    !type_input && is_first_tab || type_input && type_input == type_sort ? "active" : ""
  end

  def user_comment_recently_of_post post
    post.comments.present? ? post.comments.first.user.name : nil
  end

  def load_btn_correct_answer answer, post
    if current_user.present? && !answer.best_answer && current_user.id == post.user_id && answer.user != current_user
      return link_to t(".correct_answer"), "javascript:",
        class: "btn btn-sm btn-default btn-hover-primary correct-answer", data: {id: answer.id}
    end
  end

  def load_btn_reactions item, title, type
    case
    when type == Settings.reaction_type.like
      content = '<span class="count-like">' + "#{item.reactions.like.size}" + '</span><i class="fa fa-thumbs-up"></i>'
    when type == Settings.reaction_type.dislike
      content = '<span class="count-dislike">' + "#{item.reactions.dislike.size}" + '</span><i class="fa fa-thumbs-down"></i>'
    else
      content = '<span class="count-heart">' + "#{item.reactions.heart.size}" + '</span><i class="fa fa-heartbeat"></i>'
    end
    if current_user.present?
      link_to "javascript:", class: "btn btn-sm btn-default btn-vote",
        data: {toggle: "tooltip", placement: "bottom", "original-title": title,
        model: item.class.name, type: type, id: item.id } do
        raw content
      end
    else
      link_to "javascript:", class: "btn btn-sm btn-default btn-loggin-continue",
        data: {toggle: "tooltip", placement: "bottom", "original-title": title} do
        raw content
      end
    end
  end

  def load_button_edit_delete_comment comment
    if current_user.present? && comment.user == current_user
      "| " + (link_to "#modal-edit-comment", data: {toggle: "modal", id: comment.id},
        class: "btn-edit-comment" do
        raw '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> ' + t("edit")
      end) + " | " +
      (link_to "javascript:", class: "btn-delete-comment", data: {id: comment.id} do
        raw '<i class="fa fa-trash-o" aria-hidden="true"></i> ' + t("delete")
      end)
    end
  end

  def load_button_edit_delete_answer answer
    if current_user.present? && answer.user == current_user
      "| " + (link_to edit_answer_path(answer,edit_content: true), remote: true, class: "btn-edit-answer" do
        raw '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> ' + t("edit")
      end) + " | " +
      (link_to "javascript:", class: "btn-delete-answer", data: {id: answer.id} do
        raw '<i class="fa fa-trash-o" aria-hidden="true"></i> ' + t("delete")
      end)
    end
  end

  def load_button_functions_post post
    case
    when current_user.present? && post.user == current_user
      (link_to edit_post_path(post.id) do
        raw '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> ' + t("edit")
      end) + " | " +
      (link_to "javascript:", id: "btn-delete-post", data: {id: post.id} do
        raw '<i class="fa fa-trash-o" aria-hidden="true"></i> ' + t("delete")
      end)
    when current_user.present? && post.user != current_user
      if Clip.find_by user_id: current_user.id, post_id:  post.id
        (link_to "javascript:", id: "btn-destroy-clip", data: {id: post.id} do
          raw '<i class="fa fa-paperclip" aria-hidden="true"></i> ' + t("unclip")
        end)
      else
        (link_to "javascript:", id: "btn-create-clip", data: {id: post.id} do
          raw '<i class="fa fa-paperclip" aria-hidden="true"></i> ' + t("clip")
        end)
      end
    end
  end

  def value_tags tags
    tags.map(&:name).to_s.gsub(/[\"\]\[]/, "")
  end

  def load_icon_clip post
    if current_user.present? && Clip.find_by(user_id: current_user.id, post_id:  post.id)
      raw '<span class="glyphicon glyphicon-pushpin icon-clip"></span>'
    end
  end

  def check_workspace_feedback post
    return post.topic_id == 2
  end

   def check_a_version_for_post post
    return post.a_versions.get_version_accept.first
  end

  def content_post post
    check_a_version_for_post(post) ?
      raw(check_a_version_for_post(post).content) : raw(post.content)
  end
end
