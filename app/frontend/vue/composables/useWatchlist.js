const {ref} = Vue
import {getWatchlistStatus, updateState} from '../services/api'
import {debounce} from 'lodash'

export function useWatchlist(movieId) {
  const isInWatchlist = ref(false)

  const fetchInitialWatchlistStatus = async () => {
    try {
      const watchlistData = await getWatchlistStatus(movieId)
      isInWatchlist.value = watchlistData.isInWatchlist
    } catch (error) {
      console.error('Error fetching initial watchlist status:', error)
    }
  }

  const toggleWatchlist = debounce(async () => {
    const action = isInWatchlist.value ? 'delete' : 'post'
    try {
      const response = await updateState('watchlist', action, movieId)
      if (response.success) {
        isInWatchlist.value = response.isInWatchlist
      }
    } catch (error) {
      console.error('Error toggling watchlist status:', error)
    }
  }, 200)

  return {
    isInWatchlist,
    fetchInitialWatchlistStatus,
    toggleWatchlist
  }
}