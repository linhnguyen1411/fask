class SendEmailNotificationJob < ApplicationJob
  queue_as :default

  def perform owner_user, comment_user, post
    UserNotificationsMailer.comment_post(owner_user, comment_user, post).deliver_later
  end
end
