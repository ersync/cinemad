class ReviewSerializer < BaseSerializer
  def self.serialize_collection(reviews)
    reviews.map { |review| serialize(review) }
  end
  
  def self.serialize(review)
    return nil if review.nil?
    new(review).serialize
  end
  
  def self.serialize_preview(review)
    return nil if review.nil?
    new(review).serialize_preview
  end

  def serialize
    {
      id: @object.id,
      content: @object.content,
      rating: get_user_rating,
      created_at: format_date(@object.created_at),
      updated_at: format_date(@object.updated_at),
      user: serialize_user_minimal
    }
  end
  
  def serialize_preview
    {
      id: @object.id,
      content: format_content,
      rating: get_user_rating,
      created_at: format_date(@object.created_at),
      user: serialize_user_minimal
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

  def serialize_user_minimal
    {
      id: @object.user.id,
      username: @object.user.username,
      avatar_url: @object.user.avatar_url
    }
  end
  
  # Keep this method for backward compatibility if needed elsewhere
  def serialize_user
    UserSerializer.serialize_profile(@object.user)
  end
end