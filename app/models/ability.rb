class Ability
  include CanCan::Ability
  def initialize user
    if user.id == Settings.anonymous_number
      can :read, [Reaction, User, Post]
      can :create, Post do |post|
        post.topic_id != Settings.topic.q_a_number
      end
    else
      can :manage, :all
    end
  end
end
