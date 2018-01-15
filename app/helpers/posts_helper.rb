module PostsHelper
  def load_select_box_account
    [[current_user.name, current_user.id], [I18n.t("anonymous"), Settings.anonymous_number]]
  end

  def load_select_box_topic topic_list
    topic_list.collect{|t| [t.name, t.id]}
  end

  def load_select_box_work_space work_space_list
    work_space_list.collect{|w| [w.name, w.id]}
  end

  def check_user_reaction item, user
    item.reactions.select{|reaction| reaction.target_type != Settings.reaction_type.dislike}
    .map(&:user_id).include? user.id
  end

  def count_likes item
    length_custom item[Settings.reaction_type.like]
  end

  def count_loves item
    length_custom item[Settings.reaction_type.heart]
  end

  def count_dislikes item
    length_custom item[Settings.reaction_type.dislike]
  end

  def count_like_and_love item
    count_likes(item) + count_loves(item)
  end

  def length_custom array
    array.present? ? array.length : 0
  end

  def content_post post, a_version
    a_version ? raw(a_version.content) : raw(post.content)
  end

  def load_time_created_at object
    if object.created_at > Settings.one_day.day.ago
      time_ago_in_words object.created_at
    else
      object.created_at.strftime("%d/%m/%Y")
    end
  end

  def load_icon_clip clip_list
    if current_user.present? && clip_list.pluck(:user_id).include?(current_user.id)
      raw '<span class="glyphicon glyphicon-pushpin icon-clip"></span>'
    end
  end

  def load_approve_reject_feedback_button feedback
    if feedback.status == Settings.version.accept
      (link_to "javascript:", class: "btn-reject-feedback feedback-status-action",
        data: {id: feedback.id, status: :reject, current_status: feedback.status} do
          raw '<i class="fa fa-times" aria-hidden="true"></i>' + I18n.t("version.reject")
        end)
    else
      (link_to "javascript:", data: {id: feedback.id, status: :accept},
        class: "btn-accept-feedback feedback-status-action", id: "accept-#{feedback.id}" do
        raw '<i class="fa fa-check" aria-hidden="true"></i> ' + I18n.t("version.accept")
        end) +
      (link_to "javascript:", class: "btn-reject-feedback feedback-status-action", data:
        {id: feedback.id, status: :reject, current_status: feedback.status } do
          raw '<i class="fa fa-times" aria-hidden="true"></i> ' + I18n.t("version.reject")
        end)
    end
  end

  def load_button_functions_post post
    case
    when current_user.present? && post.user == current_user && post.waiting?
      (link_to edit_post_path(post.id) do
        raw '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> ' + t("edit")
      end) + " | " +
      (link_to "javascript:", id: "btn-delete-post", data: {id: post.id} do
        raw '<i class="fa fa-trash-o" aria-hidden="true"></i> ' + t("delete")
      end)
    when current_user.present? && post.user == current_user && post.accept? && post.topic_id != Settings.topic.feedback_number
      (link_to edit_post_path(post.id) do
        raw '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> ' + t("edit")
      end) + " | " +
      (link_to "javascript:", id: "btn-delete-post", data: {id: post.id} do
        raw '<i class="fa fa-trash-o" aria-hidden="true"></i> ' + t("delete")
      end)
    when current_user.present? && post.user == current_user && post.reject?
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

  def load_btn_reactions item, title, type
    reactions = item.reactions.group_by{|reaction| reaction.target_type}
    case
    when type == Settings.reaction_type.like
      content = '<span class="count-like">' + "#{count_likes reactions}" + '</span><i class="fa fa-thumbs-up"></i>'
    when type == Settings.reaction_type.dislike
      content = '<span class="count-dislike">' + "#{count_dislikes reactions}" + '</span><i class="fa fa-thumbs-down"></i>'
    else
      content = '<span class="count-heart">' + "#{count_loves reactions}" + '</span><i class="fa fa-heartbeat"></i>'
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

  def load_link_reaction item
    reactions = item.reactions.group_by{|reaction| reaction.target_type}
    if count_like_and_love(reactions) > Settings.zero_reaction
      (link_to reactions_path(item_id: item.id, model: item.class.name), remote: :true,
        class: "link-reaction-#{item.id} link-reaction" do
        if check_user_reaction(item, current_user) && count_like_and_love(reactions) >= Settings.two_reaction
          t("reactions.you_and") + (count_like_and_love(reactions) - Settings.one_reaction).to_s + " " +
          t("reactions.another_people")
        elsif check_user_reaction(item, current_user) && count_like_and_love(reactions) == Settings.one_reaction
          t("reactions.you_like")
        else
          count_like_and_love(reactions).to_s + " " + t("reactions.another_people")
        end
      end)
    else
      (link_to reactions_path(item_id: item.id, model: item.class.name), remote: :true, class: "link-reaction-#{item.id} link-reaction" do
      end)
    end
  end

  def load_btn_correct_answer answer, post
    if current_user.present? && !answer.best_answer && current_user.id == post.user_id && answer.user != current_user
      return link_to t(".correct_answer"), "javascript:",
        class: "btn btn-sm btn-default btn-hover-primary correct-answer", data: {id: answer.id}
    end
  end

  def check_answer_in_feedback_topic answer, topic_id
    !check_feeback_topic(topic_id) && current_user == answer.user ||
      check_permited_user_feedback && check_feeback_topic(topic_id)
  end

  def load_button_edit_delete_answer answer, topic_id
    if check_answer_in_feedback_topic answer, topic_id
      "| " + (link_to edit_answer_path(answer,edit_content: true), remote: true, class: "btn-edit-answer" do
        raw '<i class="fa fa-pencil-square-o" aria-hidden="true"></i> ' + t("edit")
      end) + " | " +
      (link_to "javascript:", class: "btn-delete-answer", data: {id: answer.id} do
        raw '<i class="fa fa-trash-o" aria-hidden="true"></i> ' + t("delete")
      end)
    end
  end

  def check_status_of_post post
    if post.waiting?
      raw('<span class="post-note">' +  t("posts.status.feedback_info") + '</span>')
    elsif post.reject?
      raw('<span class="post-note">' +  t("posts.status.feedback_reject") + '</span>')
    end
  end
end
