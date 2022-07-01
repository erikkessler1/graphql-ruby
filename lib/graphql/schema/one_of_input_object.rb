# frozen_string_literal: true

module GraphQL
  class Schema
    class OneOfInputObject < GraphQL::Schema::InputObject
      class << self
        def inherited(cls)
          cls.directive GraphQL::Schema::Directive::OneOf
        end

        def argument(*args, **kwargs, &block)
          kwargs[:required] = false if kwargs[:required].nil?

          argument = super(*args, **kwargs, &block)
          validate_argument_non_null(argument)
          validate_argument_no_default(argument)

          argument
        end

        private

        def validate_argument_non_null(argument)
          return unless argument.type.kind.non_null?

          raise ArgumentError, "Argument #{graphql_name}.#{argument.name} must be nullable " \
                               "as it is part of a OneOf Type."
        end

        def validate_argument_no_default(argument)
          return unless argument.default_value?

          raise ArgumentError, "Argument #{graphql_name}.#{argument.name} cannot have a default value " \
                               "as it is part of a OneOf Type."
        end
      end
    end
  end
end
