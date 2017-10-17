module StaticPagesHelper
  def total_post
    Post.all.size
  end

  def total_answer
    Answer.all.size
  end

  def total_member
    User.all.size
  end

  def total_comment
    Comment.all.size
  end

  def count_comment post
    post.comments.size
  end
end
