module MovieDataHelper
  def genre_options
    ['action', 'adventure', 'animation', 'comedy', 'crime', 'documentary', 'drama', 'family', 'fantasy',
     'history', 'horror', 'music', 'mystery', 'romance', 'science fiction', 'TV movie', 'thriller', 'war', 'western']
  end

  def certification_options
    ['NR', 'G', 'PG', 'PG-13', 'R', 'NC-17']
  end

  def sort_options
    [
      ['Popularity Descending', 'popularity_desc'],
      ['Popularity Ascending', 'popularity_asc'],
      ['Rating Descending', 'rating_desc'],
      ['Rating Ascending', 'rating_asc'],
      ['Release Date Descending', 'release_date_desc'],
      ['Release Date Ascending', 'release_date_asc'],
      ['Title (A-Z)', 'title_asc'],
      ['Title (Z-A)', 'title_desc']
    ]
  end

  def availability_options
    [:stream, :free, :ads, :rent, :buy]
  end

  def release_format_options
    [:theatrical, :premiere, :digital, :physical, :tv]
  end

  def language_options
    [
      ['English', 'en'],
      ['Spanish', 'es'],
      ['French', 'fr'],
      ['German', 'de'],
      ['Italian', 'it'],
      ['Japanese', 'ja'],
      ['Korean', 'ko'],
      ['Chinese', 'zh']
    ]
  end
end