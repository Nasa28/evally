# frozen_string_literal: true

module V2
  module Dashboard
    class ShowView < Blueprinter::Base
      association :employees, blueprint: V2::Employees::Serializer, default: []

      association :drafts, blueprint: V2::Evaluations::Serializer, default: []

      association :activities, blueprint: V2::Activities::Serializer, default: []

      association :templates, blueprint: V2::Templates::Serializer, default: []
    end
  end
end