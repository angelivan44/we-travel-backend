class UserPolicy < ApplicationPolicy

  def update?
    user == record
  end

  def edit?
    user == record
  end

  def destroy?
    user == record
  end

  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      scope.all
    end
  end
end
