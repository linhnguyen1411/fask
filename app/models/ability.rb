class Ability
  include CanCan::Ability
  def initialize user
    if user.id == Settings.anonymous_number
      can :read, [Reaction, User, Post, Topic]
      can :create, Post do |post|
        post.topic_id == Settings.topic.feedback_number
      end
    else
      can :manage, :all
    end
    cannot :read, Topic do |topic|
      topic.id != Settings.topic.feedback_number
    end
  end
end
