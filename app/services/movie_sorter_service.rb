class MovieSorterService
  VALID_SORT_OPTIONS = %w[
    popularity_desc popularity_asc
    rating_desc rating_asc
    release_date_desc release_date_asc
    title_desc title_asc
  ]

  DEFAULT_SORT_OPTION = 'popularity_desc'

  def initialize(collection, params)
    @collection = collection
    @params = params
  end

  def call
    sort_by = @params[:sort_by] || DEFAULT_SORT_OPTION
    if valid_sort_option?(sort_by)
      [@collection.sort_by_field(sort_by), false]
    else
      [@collection.order(:id), true]
    end
  end

  private

  def valid_sort_option?(sort_by)
    VALID_SORT_OPTIONS.include?(sort_by)
  end
end
