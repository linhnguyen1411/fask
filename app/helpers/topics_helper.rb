module TopicsHelper
  def load_select_box_location work_space_list
    work_space_list.collect{|w| [w.name, w.id]}.unshift([t("all_location"), nil])
  end

  def load_select_box_category categories
    categories.present? ? categories.collect{|w| [w.name, w.id]} : []
  end

  def work_space_id work_space
    return work_space.id if work_space.present?
  end

  def work_space_name work_space
    work_space.present? ? work_space.name : t("all_location")
  end

  def check_feeback_topic topic_id
    topic_id == Settings.topic.feedback_number
  end

  def count_vote post
    reactions = post.reactions.group_by{|reaction| reaction.target_type}
    count_upvote = reactions["upvote"].present? ? reactions["upvote"].length : 0
    count_downvote = reactions["downvote"].present? ? reactions["downvote"].length : 0
    count_upvote - count_downvote
  end
end
