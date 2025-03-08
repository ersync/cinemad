class MovieSortStrategy
  def self.for(sort_param)
    strategy_class = case sort_param
                     when /^rating/ then Sorting::RatingStrategy
                     else Sorting::SqlStrategy
                     end

    strategy_class.new(sort_param)
  end
end