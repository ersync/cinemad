module Filters
  class Genre < BaseFilter
    def applicable?
      @params[:genres].is_a?(Array) && @params[:genres].any?
    end

    def apply(relation)
      relation.joins(:categories)
              .where(categories: { name: @params[:genres].map(&:downcase) })
              .distinct
    end
  end
end