import Fetch from '@/services/fetch'

class UserApiService {
  constructor() {
    this.fetchInstance = new Fetch()
    this.baseUrl = '/api/users'
    this.movieBaseUrl = '/api/movies'
  }

  buildUserUrl(username, endpoint = '') {
    if (!username) {
      return endpoint ? `${this.baseUrl}/${endpoint}` : this.baseUrl
    }
    return endpoint ? `${this.baseUrl}/${username}/${endpoint}` : `${this.baseUrl}/${username}`
  }

  buildMovieUrl(movieSlug, action) {
    return `${this.movieBaseUrl}/${movieSlug}/${action}`
  }

  // ============================================
  // USER-RELATED REQUESTS (uses /api/users/...)
  // ============================================

  async userRequest(method, username, endpoint, data = null, options = {}) {
    const url = this.buildUserUrl(username, endpoint)
    return this.fetchInstance.makeRequest(method, url, data, options)
  }

  // ============================================
  // MOVIE-RELATED REQUESTS (uses /api/movies/...)
  // ============================================

  async movieRequest(method, movieSlug, action, data = null, options = {}) {
    const url = this.buildMovieUrl(movieSlug, action)
    return this.fetchInstance.makeRequest(method, url, data, options)
  }

  // ============================================
  // USER ENDPOINTS (/api/users/...)
  // ============================================

  async getCurrentUser() {
    try {
      const response = await this.userRequest('get', null, 'current', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async getUser(username) {
    try {
      const response = await this.userRequest('get', username)
      return response
    } catch (error) {
      return error.message
    }
  }

  async updateCurrentUser(currentUsername, userData) {
    try {
      const response = await this.userRequest('patch', currentUsername, null, { user: userData })
      return response
    } catch (error) {
      return error.message
    }
  }

  async getUserList(username, listType, page = 1) {
    try {
      const queryParams = new URLSearchParams({ page })
      const response = await this.userRequest('get', username, `${listType}?${queryParams}`)
      return response
    } catch (error) {
      return error.message
    }
  }

  async getUserWatchlist(username, page = 1) {
    return this.getUserList(username, 'watchlist', page)
  }

  async getUserFavorites(username, page = 1) {
    return this.getUserList(username, 'favorites', page)
  }

  async getUserRatings(username, page = 1) {
    return this.getUserList(username, 'ratings', page)
  }

  // ============================================
  // MOVIE INTERACTIONS (/api/movies/...)
  // ============================================

  async getWatchlistStatus(movieSlug) {
    try {
      const response = await this.movieRequest('get', movieSlug, 'watchlist', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async addToWatchlist(movieSlug) {
    try {
      const response = await this.movieRequest('post', movieSlug, 'watchlist', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async removeFromWatchlist(movieSlug) {
    try {
      const response = await this.movieRequest('delete', movieSlug, 'watchlist', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async getFavoriteStatus(movieSlug) {
    try {
      const response = await this.movieRequest('get', movieSlug, 'favorite', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async addToFavorites(movieSlug) {
    try {
      const response = await this.movieRequest('post', movieSlug, 'favorite', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async removeFromFavorites(movieSlug) {
    try {
      const response = await this.movieRequest('delete', movieSlug, 'favorite', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async getRating(movieSlug) {
    try {
      const response = await this.movieRequest('get', movieSlug, 'rating', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async setRate(movieSlug, rate) {
    try {
      const response = await this.movieRequest('post', movieSlug, 'rating', { score: rate }, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  async unsetRate(movieSlug) {
    try {
      const response = await this.movieRequest('delete', movieSlug, 'rating', null, { skipLoader: true })
      return response
    } catch (error) {
      return error.message
    }
  }

  // ============================================
  // Profile Media Operations (/api/users/...)
  // ============================================

  async uploadAvatar(username, file) {
    try {
      const formData = new FormData()
      formData.append('avatar', file)

      const response = await this.userRequest('post', username, 'avatar', formData, {
        headers: { 'Content-Type': 'multipart/form-data' }
      })
      return response
    } catch (error) {
      return error.message
    }
  }

  async removeAvatar(username) {
    try {
      const response = await this.userRequest('delete', username, 'avatar')
      return response
    } catch (error) {
      return error.message
    }
  }
}

export const userApiService = new UserApiService()