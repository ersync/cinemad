class MovieReviewsService
  attr_reader :movie, :page, :per_page

  def initialize(movie, page: 1, per_page: 5)
	@movie = movie
	@page = page.to_i
	@per_page = per_page.to_i
  end

  def fetch_paginated_reviews
	{
	  items: paginated_reviews,
	  pagination: pagination_data
	}
  end

  private

  def paginated_reviews
	if page == 1 && featured_review.present?
	  [featured_review] + remaining_first_page_reviews
	else
	  regular_paginated_reviews
	end
  end

  def featured_review
	@featured_review ||= movie.featured_review
  end

  def remaining_first_page_reviews
	movie.reviews
	  .includes(:user)
	  .where.not(id: featured_review.id)
	  .order(created_at: :desc)
	  .limit(per_page - 1)
  end

  def regular_paginated_reviews
	offset_adjustment = (featured_review.present? && page > 1) ? 1 : 0
	offset = (page - 1) * per_page - offset_adjustment
	
	movie.reviews
	  .includes(:user)
	  .where.not(id: featured_review&.id)
	  .order(created_at: :desc)
	  .offset([0, offset].max)
	  .limit(per_page)
  end

  def pagination_data
	{
	  total_pages: total_pages,
	  total_count: total_count,
	  current_page: page
	}
  end

  def total_count
	movie.reviews.count
  end

  def total_pages
	(total_count.to_f / per_page).ceil
  end
end