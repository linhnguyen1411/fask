module UsersHelper
  def get_avatar_user user
    user.avatar? ? user.avatar : "no_avatar.png"
  end
end
