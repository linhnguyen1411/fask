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
end
