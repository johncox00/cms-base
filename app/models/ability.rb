class Ability
  include CanCan::Ability

  def initialize(user)
    # Define abilities for the passed in user here. For example:
    #
    #   user ||= User.new # guest user (not logged in)
    #   if user.admin?
    #     can :manage, :all
    #   else
    #     can :read, :all
    #   end
    #
    # The first argument to `can` is the action you are giving the user
    # permission to do.
    # If you pass :manage it will apply to every action. Other common actions
    # here are :read, :create, :update and :destroy.
    #
    # The second argument is the resource the user can perform the action on.
    # If you pass :all it will apply to every resource. Otherwise pass a Ruby
    # class of the resource.
    #
    # The third argument is an optional hash of conditions to further filter the
    # objects.
    # For example, here the user can only update published articles.
    #
    #   can :update, Article, :published => true
    #
    # See the wiki for details:
    # https://github.com/CanCanCommunity/cancancan/wiki/Defining-Abilities
    user ||= User.new

    if user.admin?
      can :manage, :all
    else
      can [:read, :update], User, id: user.id
      cannot [:read, :update, :list, :destroy], User, User.all do |user|
        user.id != user.id
      end
      if user.content_creator? || user.content_approver?
        can :read, CmsPage
      end
      if user.content_creator?
        can :read, ContentItemRevision
        can [:create, :update, :destroy], ContentItemRevision
        cannot [:update, :destroy], ContentItemRevision
        can :read, ContentItem
        can [:create, :update], ContentItem
        cannot :destroy, ContentItem
        can [:create, :update], ChangeSet, ChangeSet.unaccepted do |cs|
          cs.workflow_state != 'accepted'
        end
        can :read, ChangeSet
      end
      if user.content_approver?
        can [:read, :update], ContentItemRevision
        can :manage, ContentItem
        can [:manage, :approve, :reject], ChangeSet
      end
      if user.offer_creator?
        can [:read, :create, :update], Offer
        cannot :destroy, Offer
      end
      if user.offer_approver?
        can [:read, :update, :destroy], Offer
      end
    end
  end
end
