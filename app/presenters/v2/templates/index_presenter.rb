# frozen_string_literal: true

module V2
  module Templates
    class IndexPresenter
      def initialize(scope)
        @scope = scope
      end

      def templates
        @scope.includes(:creator).order(name: :asc)
      end

      def destinations
        Template.destinations.keys.collect { |val| { value: val, text: val.titleize } }
      end
    end
  end
end
