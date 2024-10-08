import {defineStore} from 'pinia'
import {ref, computed} from 'vue'
import {movieApiService} from '@/services/movieApiService'

export const useMovieStore = defineStore('movieStore', () => {
  const movieStates = ref(new Map())
  const errors = ref(new Map())
  const loading = ref(new Map())

  // Helper functions
  const getOrCreateMovieState = (movieId) => {
    if (!movieStates.value.has(movieId)) {
      movieStates.value.set(movieId, {
        isFavorite: false,
        isInWatchlist: false,
        userRate: 0,
        avgRate: 0,
        media: {},
      })
    }
    return movieStates.value.get(movieId)
  }

  const setError = (movieId, error) => errors.value.set(movieId, error)
  const setLoading = (movieId, isLoading) => loading.value.set(movieId, isLoading)

  // Action executor
  const executeAction = async (movieId, action, errorMessage) => {
    setLoading(movieId, true)
    try {
      const result = await action()
      setError(movieId, null)
      return result
    } catch (error) {
      console.error(`Error: ${errorMessage}`, error)
      setError(movieId, {message: errorMessage, details: error})
      throw error
    } finally {
      setLoading(movieId, false)
    }
  }

  // API actions
  const fetchMovieDetails = async (movieId, options = {}) => {
    return executeAction(movieId, async () => {
      const state = getOrCreateMovieState(movieId)
      const promises = []

      if (options.favorite !== false) {
        promises.push(movieApiService.getFavoriteStatus(movieId).then(favorite => {
          state.isFavorite = favorite.isFavorite
        }))
      }

      if (options.watchlist !== false) {
        promises.push(movieApiService.getWatchlistStatus(movieId).then(watchlist => {
          state.isInWatchlist = watchlist.isInWatchlist
        }))
      }

      if (options.rate !== false) {
        promises.push(movieApiService.getRate(movieId).then(rate => {
          state.userRate = rate.score
        }))
      }

      if (options.avgRate !== false) {
        promises.push(movieApiService.getAverageRate(movieId).then(avgRate => {
          state.avgRate = avgRate.avg_rate
        }))
      }

      await Promise.all(promises)
    }, 'Failed to fetch movie details')
  }

  const toggleFavorite = async (movieId) => {
    return executeAction(movieId, async () => {
      const state = getOrCreateMovieState(movieId)
      const action = state.isFavorite ? 'delete' : 'post'
      await movieApiService.toggleFavorite(movieId, action)
      state.isFavorite = !state.isFavorite
    }, 'Failed to toggle favorite status')
  }

  const toggleWatchlist = async (movieId) => {
    return executeAction(movieId, async () => {
      const state = getOrCreateMovieState(movieId)
      const action = state.isInWatchlist ? 'delete' : 'post'
      await movieApiService.toggleWatchlist(movieId, action)
      state.isInWatchlist = !state.isInWatchlist
    }, 'Failed to toggle watchlist status')
  }

  const setRate = async (movieId, rate) => {
    return executeAction(movieId, async () => {
      await movieApiService.setRate(movieId, rate)
      getOrCreateMovieState(movieId).userRate = rate
    }, 'Failed to set rate')
  }

  const unsetRate = async (movieId) => {
    return executeAction(movieId, async () => {
      await movieApiService.unsetRate(movieId)
      getOrCreateMovieState(movieId).userRate = null
    }, 'Failed to unset rate')
  }

  const fetchMedia = async (movieId, mediaType) => {
    return executeAction(movieId, async () => {
      const media = await movieApiService.getMedia(movieId, mediaType)
      getOrCreateMovieState(movieId).media[mediaType] = media.urls
      return media.urls
    }, `Failed to fetch ${mediaType}`)
  }

  // Computed properties
  const movieComputed = (movieId) => ({
    isFavorite: computed(() => getOrCreateMovieState(movieId).isFavorite),
    isInWatchlist: computed(() => getOrCreateMovieState(movieId).isInWatchlist),
    userRate: computed(() => getOrCreateMovieState(movieId).userRate),
    avgRate: computed(() => getOrCreateMovieState(movieId).avgRate),
    media: computed(() => getOrCreateMovieState(movieId).media),
    error: computed(() => errors.value.get(movieId)),
    isLoading: computed(() => loading.value.get(movieId)),
  })

  return {
    getOrCreateMovieState,
    fetchMovieDetails,
    toggleFavorite,
    toggleWatchlist,
    setRate,
    unsetRate,
    fetchMedia,
    movieComputed,
    resetError: (movieId) => setError(movieId, null),
  }
})






