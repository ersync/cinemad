module Filters
  class DateRange < BaseFilter
    def applicable?
      valid_date?(@params[:date_from]) || valid_date?(@params[:date_to])
    end

    def apply(relation)
      from_date = parse_date(@params[:date_from])
      to_date = parse_date(@params[:date_to])

      scope = relation
      scope = scope.where('release_date >= ?', from_date) if from_date
      scope = scope.where('release_date <= ?', to_date) if to_date
      scope
    end

    private

    def valid_date?(date)
      return false if date.blank?
      Date.parse(date)
      true
    rescue ArgumentError
      false
    end

    def parse_date(date)
      return nil if date.blank?
      Date.parse(date)
    rescue ArgumentError
      nil
    end
  end
end
