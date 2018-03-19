# Ability Authorizate
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)

    if user.has_role? :admin
      can :manage, KepplerContactUs::Message
      can :manage, KepplerContactUs::MessageSetting
      # - Chart authorize -
      can :manage, Chart

      # - Banner authorize -
      can :manage, Banner

      # - Indicator authorize -
      can :manage, Indicator

      # - Customize authorize -
      can [:delete, :update,
           :new, :create, :install_default,
           :index, :destroy, :destroy_multiple], Customize

      # - Seo authorize -
      can :manage, MetaTag
      can :manage, GoogleAdword

      # - GoogleAnalytics authorize -
      if Setting.first.google_analytics_setting.ga_status
        can :manage, GoogleAnalyticsTrack
      end

      # - Setting authorize -
      can :manage, Setting

      # - User authorize -
      can [:delete, :show, :edit, :update,
           :create, :index, :destroy_multiple], User
      can :destroy, User do |u|
        !u.eql?(user)
      end

    elsif user.has_role? :client
      can :manage, KepplerContactUs::Message
      can :manage, KepplerContactUs::MessageSetting
      # - Chart authorize -
      can :manage, Chart

      # - Banner authorize -
      can :manage, Banner

      # - Indicator authorize -
      can :manage, Indicator

      # - Seo authorize -
      can :manage, MetaTag
      can :manage, GoogleAdword

      # - GoogleAnalytics authorize -
      if Setting.first.google_analytics_setting.ga_status
        can :manage, GoogleAnalyticsTrack
      end

      # - Setting authorize -
      can :manage, Setting
    end

  end
end
