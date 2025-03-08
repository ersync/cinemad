module Filters
  class Language < BaseFilter
    def applicable?
      @params[:language].present?
    end

    def apply(relation)
      relation.where(language: @params[:language])
    end
  end
end