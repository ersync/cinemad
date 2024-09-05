const {onMounted, ref, computed} = Vue
import {useMovieRating} from '../composables/useMovieRating'
import {useFavorite} from '../composables/useFavorite'
import {useWatchlist} from '../composables/useWatchlist'

export function movieRatingWidget(movieId) {
  if (!movieId) {
    console.error('Movie ID is required')
    throw new Error('Movie ID is required')
  }

  const isLoading = ref(true)
  const error = ref(null)

  const {
    rate,
    avgRate,
    rateWidth,
    hoveredRateWidth,
    setRate: originalSetRate,
    unsetRate: originalUnsetRate,
    setHoveredRateWidth,
    resetHoveredRateWidth,
    fetchInitialRate,
    fetchAvgRate,
    rateClass
  } = useMovieRating(movieId)

  const {
    isFavorite,
    fetchInitialFavoriteStatus,
    toggleFavorite: originalToggleFavorite
  } = useFavorite(movieId)

  const {
    isInWatchlist,
    fetchInitialWatchlistStatus,
    toggleWatchlist: originalToggleWatchlist
  } = useWatchlist(movieId)

  const initializeWidget = async () => {
    try {
      await Promise.all([
        fetchInitialRate(),
        fetchInitialFavoriteStatus(),
        fetchInitialWatchlistStatus(),
        fetchAvgRate()
      ])
    } catch (e) {
      console.error('Failed to initialize widget:', e)
      error.value = 'Failed to load movie data'
    } finally {
      isLoading.value = false
    }
  }

  onMounted(initializeWidget)

  const canRate = computed(() => !isLoading.value && !error.value)

  const setRate = async (...args) => {
    if (canRate.value) {
      try {
        await originalSetRate(...args)
      } catch (e) {
        console.error('Failed to set rate:', e)
        error.value = 'Failed to update rating'
      }
    }
  }

  const unsetRate = async () => {
    if (canRate.value) {
      try {
        await originalUnsetRate()
      } catch (e) {
        console.error('Failed to unset rate:', e)
        error.value = 'Failed to remove rating'
      }
    }
  }

  const toggleFavorite = async () => {
    try {
      await originalToggleFavorite()
    } catch (e) {
      console.error('Failed to toggle favorite:', e)
      error.value = 'Failed to update favorite status'
    }
  }

  const toggleWatchlist = async () => {
    try {
      await originalToggleWatchlist()
    } catch (e) {
      console.error('Failed to toggle watchlist:', e)
      error.value = 'Failed to update watchlist status'
    }
  }

  return {
    isLoading,
    error,
    isFavorite,
    isInWatchlist,
    toggleWatchlist,
    toggleFavorite,
    rateWidth,
    hoveredRateWidth,
    resetHoveredRateWidth,
    setHoveredRateWidth,
    rate,
    rateClass,
    avgRate,
    setRate,
    unsetRate,
    canRate
  }
}