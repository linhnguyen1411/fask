class Supports::UserSupport
  def initialize user
   @user = user
  end

  def comments_of_user
    @user.comments
  end

  def answers_of_user
    @user.answers
  end

  def posts_of_user
    @user.posts.post_of_topic_on.accept
  end
end
