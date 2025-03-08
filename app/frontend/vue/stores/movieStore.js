import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { movieApiService } from '@/services/movieApiService'

export const useMovieStore = defineStore('movieStore', () => {
  const movieCache = ref(new Map())
  const loading = ref(new Map())
  const errors = ref(new Map())

  const getOrCreateMovieCache = (slug) => {
    if (!movieCache.value.has(slug)) {
      movieCache.value.set(slug, {
        slug,
        complete: false,
        id: null,
        title: null,
        status: null,
        language: null,
        budget: null,
        revenue: null,
        cover_url: null,
        background_url: null,
        average_rating: null,
        release_date: null,
        overview: null,
        crew: [],
        cast: [],
        reviews_section: {
          stats: {
            total_count: 0
          },
          featured_review: null
        },
        age_rating: null,
        tagline: null,
        duration: null,
        categories: [],
        gradient_color: null,
        user_interactions: null,
        media: {
          posters: [],
          backdrops: [],
          videos: []
        },
        recommendations: [],
        reviews: null
      })
    }

    return movieCache.value.get(slug)
  }

  const setLoading = (slug, isLoading) => {
    loading.value.set(slug, isLoading)
  }

  const setError = (slug, error) => {
    if (error) {
      errors.value.set(slug, error)
    } else {
      errors.value.delete(slug)
    }
  }

  const fetchMovie = async (slug) => {
    setLoading(slug, true)
    setError(slug, null)

    try {
      const movieData = getOrCreateMovieCache(slug)

      const response = await movieApiService.getMovie(slug)

      if (response.success) {
        if (response.movie) {
          for (const [key, value] of Object.entries(response.movie)) {
            movieData[key] = value
          }
          movieData.complete = true
          movieData.lastFetched = Date.now()
        } else {
          throw new Error('Malformed API response: missing movie data')
        }
        return movieData
      } else {
        throw new Error(response.error || 'Failed to fetch movie details')
      }
    } catch (error) {
      const errorMessage = error.message || 'Failed to load movie'
      setError(slug, errorMessage)
      throw error
    } finally {
      setLoading(slug, false)
    }
  }

  const fetchMedia = async (slug, mediaType) => {
    const loadingKey = `${slug}-${mediaType}`
    setLoading(loadingKey, true)

    try {
      const movieData = getOrCreateMovieCache(slug)

      const response = await movieApiService.fetchMedia(slug, mediaType)

      if (response.success) {
        if (!movieData.media) {
          movieData.media = {}
        }
        movieData.media[mediaType] = response.urls || []
        return movieData.media[mediaType]
      }

      return []
    } catch (error) {
      return []
    } finally {
      setLoading(loadingKey, false)
    }
  }

  const refreshMovie = async (slug) => {
    return fetchMovie(slug)
  }

  const clearMovie = (slug) => {
    movieCache.value.delete(slug)
    loading.value.delete(slug)
    errors.value.delete(slug)
  }

  const clearAllMovies = () => {
    movieCache.value.clear()
    loading.value.clear()
    errors.value.clear()
  }

  const fetchCast = async (slug) => {
    try {
      const movieData = getOrCreateMovieCache(slug)

      // Always make API call, no cache check
      const response = await movieApiService.getCast(slug)

      if (response.success) {
        movieData.cast = response.cast
        return movieData.cast
      }
      return []
    } catch (error) {
      return []
    }
  }

  const fetchRecommendations = async (slug) => {
    try {
      const movieData = getOrCreateMovieCache(slug)

      const response = await movieApiService.getRecommendations(slug)

      if (response.success) {
        const recommendationsData = response.recommendations.recommendations || response.recommendations
        movieData.recommendations = recommendationsData
        return movieData.recommendations
      }
      return []
    } catch (error) {
      return []
    }
  }

    const movieComputed = (slug) => {
    const movieData = getOrCreateMovieCache(slug)

    return {
      data: computed(() => movieCache.value.get(slug)),
      cast: computed(() => movieCache.value.get(slug)?.cast || []),
      recommendations: computed(() => movieCache.value.get(slug)?.recommendations || []),
      review_section: computed(() => movieCache.value.get(slug)?.review_section),
      reviews: computed(() => movieCache.value.get(slug)?.reviews),
      isLoading: computed(() => loading.value.get(slug) || false),
      error: computed(() => errors.value.get(slug)),
      isComplete: computed(() => movieCache.value.get(slug)?.complete || false),
      media: computed(() => movieCache.value.get(slug)?.media || {
        posters: [],
        backdrops: [],
        videos: []
      })
    }
  }

  const isMediaLoading = (slug, mediaType) => {
    return loading.value.get(`${slug}-${mediaType}`) || false
  }

  const updateAverageRating = (slug, newRating) => {
    if (movieCache.value.has(slug)) {
      const movieData = movieCache.value.get(slug)
      movieData.average_rating = newRating
      return true
    }
    return false
  }


  return {
    fetchMovie,
    fetchMedia,
    refreshMovie,
    clearMovie,
    clearAllMovies,
    movieComputed,
    isMediaLoading,
    fetchCast,
    fetchRecommendations,
    updateAverageRating
  }
})