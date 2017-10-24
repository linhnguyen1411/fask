module UsersHelper
  def get_avatar_user user
    user.avatar? ? user.avatar.url : "no_avatar.png"
  end

  def check_follow user_id
    User.check_follow(current_user, user_id) > 0
  end

  def count_follow user
    user.followers.size
  end

  def count_posts user
    user.posts.size
  end

  def count_clips user
    user.clips.size
  end
end
