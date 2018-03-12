class Ability
  include CanCan::Ability
  def initialize user
    if user.id == Settings.anonymous_number
      can :read, [Reaction, User, Post, Topic]
      can :create, Post
    else
      can :manage, :all
    end
    cannot :manage, Topic do |topic|
      topic.status == false
    end
    if user.position == Settings.admin_position
      can :manage, :all
    end
  end
end
