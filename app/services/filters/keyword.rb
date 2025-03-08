module Filters
  class Keyword < BaseFilter
    def applicable?
      @params[:selected_keywords].is_a?(Array) && @params[:selected_keywords].any?
    end

    def apply(relation)
      relation.joins(:keywords)
              .where(keywords: { name: @params[:selected_keywords] })
              .distinct
    end
  end
end