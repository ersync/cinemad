module Filters
  class BaseFilter
    def initialize(params, current_user = nil)
      @params = params
      @current_user = current_user
    end

    def applicable?
      raise NotImplementedError
    end

    def apply(relation)
      raise NotImplementedError
    end
  end
end