# frozen_string_literal: true

module V2
  module Organizations
    class Serializer < Blueprinter::Base
      identifier :id

      fields :name
    end
  end
end
