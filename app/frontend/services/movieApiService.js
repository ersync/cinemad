import Fetch from '@/services/fetch'

class MovieApiService {
  constructor() {
    this.fetchInstance = new Fetch()
    this.baseUrl = '/api/movies' // Updated to use /api prefix
  }

  buildUrl(movieId, endpoint = '') {
    if (!movieId) {
      return endpoint ? `${this.baseUrl}/${endpoint}` : this.baseUrl
    }
    return endpoint ? `${this.baseUrl}/${movieId}/${endpoint}` : `${this.baseUrl}/${movieId}`
  }

  async request(method, movieId, endpoint, data = null) {
    const url = this.buildUrl(movieId, endpoint)
    return this.fetchInstance.makeRequest(method, url, data)
  }

  // Rating methods - matches Rateable concern
  async getRate(movieId) {
    return this.request('get', movieId, 'rate')
    // Returns: { success: true/false, ... }
  }

  async setRate(movieId, rate) {
    return this.request('post', movieId, 'rate', { rate })
    // Returns: { success: true/false, ... }
  }

  async unsetRate(movieId) {
    return this.request('delete', movieId, 'rate')
    // Returns: { success: true/false, ... }
  }

  async getAverageRate(movieId) {
    return this.request('get', movieId, 'avg_rate')
    // Returns: { avg_rate: number }
  }

  // Favorite methods - matches Favoriteable concern
  async getFavoriteStatus(movieId) {
    return this.request('get', movieId, 'favorite')
    // Returns: { isFavorite: boolean }
  }

  async addToFavorites(movieId) {
    return this.request('post', movieId, 'favorite')
    // Returns: { success: true/false, message: string }
  }

  async removeFromFavorites(movieId) {
    return this.request('delete', movieId, 'favorite')
    // Returns: { success: true/false, message: string }
  }

  // Watchlist methods - matches Watchlistable concern
  async getWatchlistStatus(movieId) {
    return this.request('get', movieId, 'watchlist')
    // Returns: { isInWatchlist: boolean }
  }

  async addToWatchlist(movieId) {
    return this.request('post', movieId, 'watchlist')
    // Returns: { success: true/false, message: string }
  }

  async removeFromWatchlist(movieId) {
    return this.request('delete', movieId, 'watchlist')
    // Returns: { success: true/false, message: string }
  }

  // Media methods - matches Mediaable concern
  async getPosters(movieId) {
    return this.request('get', movieId, 'posters')
    // Returns: { success: true, urls: string[] } or { success: false, error: string }
  }

  async getBackdrops(movieId) {
    return this.request('get', movieId, 'backdrops')
    // Returns: { success: true, urls: string[] } or { success: false, error: string }
  }

  async getVideos(movieId) {
    return this.request('get', movieId, 'videos')
    // Returns: { success: true, urls: string[] } or { success: false, error: string }
  }

  async getPopularMedia(movieId) {
    return this.request('get', movieId, 'popular_media')
    // Returns: { urls: string[] }
  }

  // Movie list methods
  async getHomeData() {
    return this.request('get', null, 'home_data')
  }

  async getMovieDetails(movieId) {
    return this.request('get', movieId)
  }
}

export const movieApiService = new MovieApiService()