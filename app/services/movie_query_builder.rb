class MovieQueryBuilder
  def initialize(base_relation)
    @relation = base_relation
  end

  def filter(params, current_user)
    return self if params.blank?

    @relation = MovieFilterChain.new(@relation, params, current_user).apply
    self
  end

  def sort(sort_param)
    return self if sort_param.blank?

    @relation = ::MovieSortStrategy.for(sort_param).apply(@relation)
    self
  end

  def results
    @relation
  end
end
