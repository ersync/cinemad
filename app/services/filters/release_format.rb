module Filters
  class ReleaseFormat < BaseFilter
    def applicable?
      return false if @params[:all_release_formats] == '1'
      selected_formats.any?
    end

    def apply(relation)
      relation.joins(:release_formats)
              .where(release_formats: { name: selected_formats })
              .distinct
    end

    private

    def selected_formats
      return [] unless @params[:release_formats].is_a?(Array)
      @params[:release_formats]
    end
  end
end