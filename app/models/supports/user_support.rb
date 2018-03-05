class Supports::UserSupport
  def initialize user
   @user = user
  end

  def comments_of_user
    @user.comments.comments_of_post_in_topic_on
  end

  def answers_of_user
    @user.answers.includes_post_and_topic_on
  end

  def posts_of_user
    @user.posts.post_of_topic_on.accept
  end
end
