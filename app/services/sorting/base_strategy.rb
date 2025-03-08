module Sorting
  class BaseStrategy
    def initialize(sort_param)
      @sort_param = sort_param
    end

    def apply(relation)
      raise NotImplementedError
    end
  end
end