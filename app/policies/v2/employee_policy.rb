# frozen_string_literal: true

module V2
  class EmployeePolicy < ApplicationPolicy
    class Scope < Scope
      def resolve
        return scope.all if user.admin? || user.recruiter?

        user.employees
      end
    end

    def archived?
      admin_or_recruiter?
    end

    def show?
      admin_or_recruiter? || assigned_evaluator?
    end

    def create?
      admin_or_recruiter?
    end

    def update?
      admin_or_recruiter?
    end

    def overview?
      admin_or_recruiter?
    end

    def archive?
      admin_or_recruiter?
    end

    def destroy?
      user.admin?
    end

    private

    def admin_or_recruiter?
      user.admin? || user.recruiter?
    end

    def assigned_evaluator?
      user.id == record.evaluator_id
    end
  end
end
