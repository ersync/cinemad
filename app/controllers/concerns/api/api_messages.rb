module Api
  module ApiMessages
    module Watchlist
      SUCCESS = {
        added: 'Movie successfully added to your watchlist',
        removed: 'Movie successfully removed from your watchlist'
      }.freeze

      ERROR = {
        already_exists: 'Movie is already in your watchlist',
        not_found: 'Movie not found in your watchlist',
        add_failed: 'Unable to add movie to your watchlist',
        remove_failed: 'Unable to remove movie from your watchlist'
      }.freeze
    end

    module Favorite
      SUCCESS = {
        added: 'Movie successfully added to your favorites',
        removed: 'Movie successfully removed from your favorites'
      }.freeze

      ERROR = {
        already_exists: 'Movie is already in your favorites',
        not_found: 'Movie not found in your favorites',
        add_failed: 'Unable to add movie to your favorites',
        remove_failed: 'Unable to remove movie from your favorites'
      }.freeze
    end

    module Rating
      SUCCESS = {
        created: 'Rating successfully added',
        updated: 'Rating successfully updated',
        removed: 'Rating successfully removed'
      }.freeze

      ERROR = {
        invalid: 'Invalid rating value. Please rate between 1 and 100',
        create_failed: 'Unable to add rating',
        update_failed: 'Unable to update rating',
        remove_failed: 'Unable to remove rating',
        not_found: 'Rating not found for this movie'
      }.freeze
    end
  end
end