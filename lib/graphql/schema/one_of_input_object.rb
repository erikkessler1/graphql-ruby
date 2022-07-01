# frozen_string_literal: true

module GraphQL
  class Schema
    class OneOfInputObject < GraphQL::Schema::InputObject
      class << self
        def inherited(cls)
          cls.directive GraphQL::Schema::Directive::OneOf
        end
      end
    end
  end
end
