class UserSerializer < BaseSerializer
  class << self
    def local_ip
      @local_ip ||= Socket.ip_address_list.detect do |addr_info|
        addr_info.ipv4? && !addr_info.ipv4_loopback? && !addr_info.ipv4_multicast?
      end&.ip_address
    end
  end

  def self.serialize_basic(user)
    new(user).serialize_basic
  end
  
  def self.serialize_profile(user)
    new(user).serialize_profile
  end

  def serialize_basic
    {
      id: @object.id,
      username: @object.username,
      email: @object.email,
      created_at: @object.created_at,
      avg_rating: @object.avg_rating,
      avatar_url: formatted_avatar_url,
      stats: serialize_stats
    }
  end
  
  def serialize_profile
    {
      id: @object.id,
      username: @object.username,
      avatar_url: formatted_avatar_url
    }
  end

  private

  def serialize_stats
    {
      total_reviews: @object.reviews.count,
      total_ratings: @object.ratings.count,
      total_favorites: @object.favorite_movies.count,
      total_watchlist: @object.watchlist&.movies&.count || 0
    }
  end

  def formatted_avatar_url
    return nil unless @object.avatar.attached?

    Rails.application.routes.url_helpers
         .url_for(@object.avatar)
         .gsub('localhost', self.class.local_ip)
  end
end