class DepartmentPolicy < ApplicationPolicy
  def create?
    user.role == "admin"
  end
  
  def update?
    create?
  end

  def edit?
    create?
  end

  def destroy?
    create?
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
