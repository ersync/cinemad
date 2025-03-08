module Filters
  class Availability < BaseFilter
    def applicable?
      return false if @params[:all_availabilities] == '1'
      selected_availabilities.any?
    end

    def apply(relation)
      relation.joins(:availabilities)
              .where(availabilities: { name: selected_availabilities })
              .distinct
    end

    private

    def selected_availabilities
      return [] unless @params[:availabilities].is_a?(ActionController::Parameters)
      @params[:availabilities].select { |_, v| v.in?(['1', 'true', true]) }.keys
    end
  end
end