class UserNotificationsMailer < ApplicationMailer
  default from: Settings.from_mail

  def comment_post owner_user, comment_user, post
    @owner_user = owner_user
    @comment_user = comment_user
    @post = post
    mail to: @owner_user.email, subject: @comment_user.name + t("mail_noti.has_been_commented") + @post.title
  end
end
