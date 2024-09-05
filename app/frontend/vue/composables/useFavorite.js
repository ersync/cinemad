const {ref} = Vue
import {getFavoriteStatus, updateState} from '../services/api'
import {debounce} from 'lodash'

export function useFavorite(movieId) {
  const isFavorite = ref(false)

  const fetchInitialFavoriteStatus = async () => {
    try {
      const favoriteData = await getFavoriteStatus(movieId)
      isFavorite.value = favoriteData.isFavorite
    } catch (error) {
      console.error('Failed to fetch initial favorite status:', error)
    }
  }

  const toggleFavorite = debounce(async () => {
    const action = isFavorite.value ? 'delete' : 'post'
    try {
      const response = await updateState('favorite', action, movieId)
      if (response.success) {
        isFavorite.value = response.isFavorite
      }
    } catch (error) {
      console.error('Failed to toggle favorite status:', error)
    }
  }, 200)

  return {
    isFavorite,
    fetchInitialFavoriteStatus,
    toggleFavorite
  }
}