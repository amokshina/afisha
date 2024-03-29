class UserPolicy < ApplicationPolicy
  def create?
    user.guest?
  end
  def update?
    user.present? && record == user
  end
  def index?
    false
  end
  def show?
    true
  end
  def destroy?
    false
  end
end