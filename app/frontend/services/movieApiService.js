import Fetch from '@/services/fetch'

class MovieApiService {
  constructor() {
    this.fetchInstance = new Fetch()
    this.baseUrl = '/movies'
  }

  buildUrl(movieId, endpoint = '') {
    return `${this.baseUrl}/${movieId}/${endpoint}`
  }

  async request(method, movieId, endpoint, data = null) {
    const url = this.buildUrl(movieId, endpoint)
    return this.fetchInstance.makeRequest(method, url, data)
  }

  async getRate(movieId) {
    return this.request('get', movieId, 'rate')
  }

  async setRate(movieId, rate) {
    return this.request('post', movieId, 'rate', {rate})
  }

  async unsetRate(movieId) {
    return this.request('delete', movieId, 'rate')
  }

  async getFavoriteStatus(movieId) {
    return this.request('get', movieId, 'favorite')
  }

  async toggleFavorite(movieId, action = 'post') {
    return this.request(action, movieId, 'favorite')
  }

  async getWatchlistStatus(movieId) {
    return this.request('get', movieId, 'watchlist')
  }

  async toggleWatchlist(movieId, action = 'post') {
    return this.request(action, movieId, 'watchlist')
  }

  async getMedia(movieId, mediaType) {
    return this.request('get', movieId, mediaType)
  }

  async getAverageRate(movieId) {
    return this.request('get', movieId, 'avg_rate')
  }
}

export const movieApiService = new MovieApiService()