class ReviewSerializer < BaseSerializer
  def self.serialize_preview(review)
    return nil if review.nil?
    new(review).serialize_preview
  end

  def serialize_preview
    {
      id: @object.id,
      content: format_content,
      rating: get_user_rating,
      created_at: format_date(@object.created_at),
      user: serialize_user
    }
  end

  private

  def format_content
    return nil if @object.content.blank?
    truncate_content(@object.content)
  end

  def truncate_content(content, limit = 610)
    "#{content[0..limit]}..."
  end

  def format_date(date)
    date.strftime("%d %B %Y")
  end

  def get_user_rating
    @object.user.ratings.find_by(movie_id: @object.movie_id)&.score
  end

  def serialize_user
    UserSerializer.serialize_basic(@object.user)
  end
end