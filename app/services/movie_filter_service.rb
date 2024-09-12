class MovieFilterService
  include MovieDataHelper

  FILTER_TYPES = %i[
    watch_status availabilities release_formats
    date_range genres certifications language keywords
  ].freeze

  def initialize(collection, params, current_user = nil)
    @collection = collection
    @params = params
    @current_user = current_user
  end

  def call
    FILTER_TYPES.each do |filter_type|
      apply_filter(filter_type)
    end
    @collection
  rescue StandardError => e
    Rails.logger.error("Error in MovieFilterService: #{e.message}")
    @collection.none
  end

  private

  def apply_filter(filter_type)
    if send("valid_#{filter_type}_filter?")
      send("apply_#{filter_type}_filter")
    else
      Rails.logger.warn("Invalid filter: #{filter_type} with params: #{@params[filter_type]}")
    end
  end

  # Watch Status Filter
  def valid_watch_status_filter?
    @current_user && %w[watched unwatched].include?(@params[:watch_status])
  end

  def apply_watch_status_filter
    case @params[:watch_status]
    when 'watched'
      @collection = @collection.joins(:ratings).where(ratings: { user_id: @current_user.id }).distinct
    when 'unwatched'
      @collection = @collection.where.not(id: Rating.where(user_id: @current_user.id).select(:movie_id)).distinct
    when ''
      # Do nothing
    else
      Rails.logger.warn("Invalid watch_status parameter: #{@params[:watch_status]}")
      @collection = @collection.none
    end

    # Add this debugging line
    Rails.logger.debug("SQL for watch_status filter: #{@collection.to_sql}")
  end

  # Availabilities Filter
  def valid_availabilities_filter?
    !all_options_selected?(:all_availabilities) && selected_options(availability_options).any?
  end

  def apply_availabilities_filter
    selected = selected_options(availability_options)
    @collection = @collection.joins(:availabilities).where(availabilities: { name: selected }).distinct
  end

  # Release Formats Filter
  def valid_release_formats_filter?
    !all_options_selected?(:all_release_formats) && selected_options(release_format_options).any?
  end

  def apply_release_formats_filter
    selected = selected_options(release_format_options)
    @collection = @collection.joins(:release_formats).where(release_formats: { name: selected }).distinct
  end

  # Date Range Filter
  def valid_date_range_filter?
    valid_date?(@params[:date_from]) && valid_date?(@params[:date_to])
  end

  def apply_date_range_filter
    from_date = parse_date(@params[:date_from])
    to_date = parse_date(@params[:date_to])
    if from_date && to_date
      @collection = @collection.where(release_date: from_date..to_date)
    elsif from_date
      @collection = @collection.where('release_date >= ?', from_date)
    elsif to_date
      @collection = @collection.where('release_date <= ?', to_date)
    end
  end

  # Genres Filter
  def valid_genres_filter?
    @params[:genres].is_a?(Array) && (@params[:genres].map(&:downcase) & genre_options).present?
  end

  def apply_genres_filter
    selected = @params[:genres].map(&:downcase) & genre_options
    @collection = @collection.joins(:categories).where(categories: { name: selected }).distinct
  end

  # Certifications Filter
  def valid_certifications_filter?
    @params[:certifications].is_a?(Array) && (@params[:certifications] & certification_options).present?
  end

  def apply_certifications_filter
    selected = @params[:certifications] & certification_options
    @collection = @collection.where(age_rating: selected)
  end

  # Language Filter
  def valid_language_filter?
    @params[:language].present? && language_options.map(&:last).include?(@params[:language])
  end

  def apply_language_filter
    @collection = @collection.where(language: @params[:language])
  end

  # Keywords Filter
  def valid_keywords_filter?
    @params[:selected_keywords].present?
  end

  def apply_keywords_filter
    keywords = parse_keywords(@params[:selected_keywords])
    @collection = @collection.joins(:keywords).where(keywords: { name: keywords }).distinct if keywords.any?
  end

  # Helper methods
  def all_options_selected?(option_key)
    @params[option_key] == '1'
  end

  def selected_options(options)
    options.select { |option| @params[option] == '1' }
  end

  def valid_date?(date)
    Date.parse(date)
    true
  rescue ArgumentError
    false
  end

  def parse_date(date)
    Date.parse(date)
  end

  def parse_keywords(keywords)
    keywords.to_s.split(',').map(&:strip).select { |k| k.match?(/\A\d+\z/) || k.match?(/\A[\w\s\d]+\z/) }
  end
end
