# frozen_string_literal: true

module V2
  class TemplateForm
    attr_reader :template

    def initialize(template, params:, user:)
      @template = template
      @params = params
      @user = user

      @template.assign_attributes(
        sections_attributes: @params.delete(:sections),
        **@parans
      )
    end

    def save
      validate_template!

      ActiveRecord::Base.transaction do
        create_activity!
        @template.save!
      end
    end

    private

    def validate_template!
      return if @template.valid?

      raise V1::ErrorResponderService.new(:invalid_record, 422, @template.errors.full_messages)
    end

    def create_activity!
      @user.activities.create!(
        action: resolved_activity_action,
        activable: @template,
        activable_name: @template.name
      )
    end

    def resolved_activity_action
      @template.new_record? ? 'create' : 'udpate'
    end
  end
end
