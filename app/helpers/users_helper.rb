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

  def count_following user
    user.following.size
  end

  def count_posts user
    user.posts.size
  end

  def count_clips user
    user.clips.size
  end

  def count_improvements user
    user.a_versions.size
  end

  def check_permited_user_feedback
    Settings.feedback_manager.include?(current_user.position)
  end

  def check_permited_user_admin
    Settings.fask_manager.include?(current_user.position)
  end
end
