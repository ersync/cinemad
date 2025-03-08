module Sorting
  class RatingStrategy < BaseStrategy
    def apply(relation)
      direction = @sort_param.end_with?('desc') ? 'DESC' : 'ASC'

      ratings_subquery = Rating.group(:movie_id)
                               .select('movie_id, AVG(score) as avg_score')
                               .to_sql

      relation
        .select('movies.*, COALESCE(avg_ratings.avg_score, 0) as avg_rating')
        .joins("LEFT JOIN (#{ratings_subquery}) AS avg_ratings ON avg_ratings.movie_id = movies.id")
        .order(Arel.sql("avg_rating #{direction}"))
    end
  end
end