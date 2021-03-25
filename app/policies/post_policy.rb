class PostPolicy < ApplicationPolicy
 
  def update?
    user == record.user
  end


  def destroy?
    user.role == "admin" || user == record.user
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
