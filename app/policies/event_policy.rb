class EventPolicy < ApplicationPolicy
  def index?
    true
  end
  def show?
    true
  end
  def create?
    user.present? && (user.manager_role? || user.admin_role?)
  end
  def update?
    user.present? && (user.admin_role? || user.author?(record))
  end
  def destroy?
    user.present? && (user.admin_role? || user.author?(record))
  end
end