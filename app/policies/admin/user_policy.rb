module Admin
  class UserPolicy < ApplicationPolicy
    def index?
      puts "User: #{user.inspect}"
      puts "Admin Role? #{user.present? && user.admin_role?}"
      user.present? && user.admin_role?
    end
    def show?
      user.present? && user.admin_role?
    end
    def create?
      user.present? && user.admin_role?
    end
    def new?
      create?
    end
    def update?
      user.present? && user.admin_role?
    end
    def edit?
      update?
    end
    def destroy?
      user.present? && user.admin_role?
    end
    class Scope < Scope
      def resolve
        scope.all
      end
    end
  end
end