# frozen_string_literal: true

module V2
  module Profile
    class OrganizationForm
      attr_reader :user

      delegate :organization, to: :user

      def initialize(user, params:)
        @user = user

        organization.assign_attributes(params)
      end

      def save
        validate_organization!

        organization.save
      end

      private

      def validate_organization!
        return if organization.valid?

        raise ErrorResponderService.new(:invalid_record, 422, organization.errors.full_messages)
      end
    end
  end
end
