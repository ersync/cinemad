import Fetch from '@/services/fetch'

class MovieApiService {
  constructor() {
    this.fetchInstance = new Fetch()
    this.baseUrl = '/api/movies'
  }

  buildUrl(slug, endpoint = '') {
    if (!slug) {
      return endpoint ? `${this.baseUrl}/${endpoint}` : this.baseUrl
    }
    return endpoint ? `${this.baseUrl}/${slug}/${endpoint}` : `${this.baseUrl}/${slug}`
  }

  async request(method, slug, endpoint, data = null, options = {}) {
    const url = this.buildUrl(slug, endpoint)
    return this.fetchInstance.makeRequest(method, url, data, options)
  }

  // ============================================
  // Movie Details and Discovery
  // ============================================

  async getMovie(slug) {
    try {
      const response = await this.request('get', slug)
      return response
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getDiscoveryMovies(params = {}) {
    try {
      const queryParams = new URLSearchParams()

      if (params.sort) queryParams.append('sort', params.sort)
      if (params.page) queryParams.append('page', params.page)
      if (params.per_page) queryParams.append('per_page', params.per_page)

      if (params.filter) {
        Object.entries(params.filter).forEach(([key, value]) => {
          if (Array.isArray(value)) {
            value.forEach(v => {
              if (v) queryParams.append(`filter[${key}][]`, v)
            })
          } else if (value && typeof value === 'object') {
            Object.entries(value).forEach(([k, v]) => {
              if (v) queryParams.append(`filter[${key}][${k}]`, v)
            })
          } else if (value) {
            queryParams.append(`filter[${key}]`, value)
          }
        })
      }

      const response = await this.request('get', null, `discovery?${queryParams.toString()}`)
      return response
    } catch (error) {
      return error.message
    }
  }

  // ============================================
  // Homepage and Search
  // ============================================

  async getHomePage() {
    try {
      const response = await this.request('get', null, 'home_page')
      return { success: true, data: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async searchMovies(query) {
    try {
      const response = await this.request('get', null, `search?query=${encodeURIComponent(query)}`, null, { skipLoader: true })
      return { success: true, results: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async searchKeywords(query) {
    try {
      const response = await this.request('get', null, `search_keywords?query=${encodeURIComponent(query)}`, null, { skipLoader: true })
      return { success: true, results: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  // ============================================
  // Media Methods
  // ============================================

  async fetchMedia(slug, mediaType) {
    try {
      const response = await this.request('get', slug, `media/${mediaType}`)
      return { success: true, urls: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getMediaPosters(slug) {
    try {
      const response = await this.request('get', slug, 'media/posters')
      return { success: true, urls: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getMediaBackdrops(slug) {
    try {
      const response = await this.request('get', slug, 'media/backdrops')
      return { success: true, urls: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getMediaVideos(slug) {
    try {
      const response = await this.request('get', slug, 'media/videos')
      return { success: true, urls: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getPopularMedia(slug) {
    try {
      const response = await this.request('get', slug, 'media/popular')
      return { success: true, media: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  // ============================================
  // Movie Information
  // ============================================

  async getCast(slug) {
    try {
      const response = await this.request('get', slug, 'cast')
      return { success: true, cast: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getRecommendations(slug) {
    try {
      const response = await this.request('get', slug, 'recommendations')
      return { success: true, recommendations: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getReviewSection(slug) {
    try {
      const response = await this.request('get', slug, 'review_section')
      return { success: true, review_section: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }

  async getAverageRating(slug) {
    try {
      const response = await this.request('get', slug, 'average_rating', null, { skipLoader: true })
      return { success: true, rating: response }
    } catch (error) {
      return { success: false, error: error.message }
    }
  }
}

export const movieApiService = new MovieApiService()