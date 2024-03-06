class CommentPolicy < ApplicationPolicy
  def index?
    true
  end
  def show?
    true
  end
  def create?
    user.present? && !user.guest?
  end
  def update?
    user.admin_role? || user.author?(record)
  end
  def destroy?
    user.admin_role? || user.author?(record)
  end
end