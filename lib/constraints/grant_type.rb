module Constraint
  class GrantType

    def initialize(grant_type)
      @grant_type = grant_type
    end

    def matches?(request)
      request.params['grant_type'] == @grant_type
    end
  end
end
