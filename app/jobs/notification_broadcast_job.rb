class NotificationBroadcastJob < ApplicationJob
  queue_as :notification

  require "action_view"
  require "action_view/helpers"
  include ActionView::Helpers::DateHelper

  def perform notification
    ActionCable.server.broadcast "notification_channel_#{notification.user_id}",
      mess: "#{notification.activity.owner.name} #{notification.load_message.first}",
      url: ("/posts/" + notification.load_message.last.to_s + "?noti_id=#{notification.id}"),
      img: notification.activity.owner.avatar.present? ? notification.activity.owner.avatar.url : "no_avatar.png",
      name: notification.activity.owner.name, time: time_ago_in_words(notification.created_at)
  end
end
