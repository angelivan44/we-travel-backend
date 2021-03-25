class UserPolicy < ApplicationPolicy

  def show?
    user == record
  end

  def update?
    user == record
  end

  def edit?
    show?
  end

  def destroy?
    show?
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
