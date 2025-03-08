module Sorting
  class SqlStrategy < BaseStrategy
    SORT_MAPPINGS = {
      'popularity_desc'    => { revenue: :desc },
      'popularity_asc'     => { revenue: :asc },
      'release_date_desc' => { release_date: :desc },
      'release_date_asc'  => { release_date: :asc },
      'title_desc'        => { title: :desc },
      'title_asc'         => { title: :asc }
    }.freeze

    def apply(relation)
      relation.order(SORT_MAPPINGS[@sort_param] || { id: :asc })
    end
  end
end
