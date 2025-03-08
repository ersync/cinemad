class MovieFilterChain
  FILTERS = [
    Filters::WatchStatus,
    Filters::Availability,
    Filters::ReleaseFormat,
    Filters::DateRange,
    Filters::Genre,
    Filters::Certification,
    Filters::Language,
    Filters::Keyword
  ].freeze

  def initialize(relation, params, current_user)
    @relation = relation
    @params = params
    @current_user = current_user
  end

  def apply
    FILTERS.reduce(@relation) do |filtered_relation, filter_class|
      filter = filter_class.new(@params, @current_user)
      filter.applicable? ? filter.apply(filtered_relation) : filtered_relation
    end
  rescue StandardError => e
    Rails.logger.error("Filter chain error: #{e.message}")
    @relation
  end
end