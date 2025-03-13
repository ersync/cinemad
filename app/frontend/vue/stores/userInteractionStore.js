import { defineStore } from 'pinia'
import { ref, computed } from 'vue'
import { useMovieStore } from '@/vue/stores/movieStore'
import { userApiService } from '@/services/userApiService'
import { useAuthStore } from '@/vue/stores/authStore'

export const useUserInteractionStore = defineStore('userInteractionStore', () => {
  const authStore = useAuthStore()

  // User profile data
  const userProfile = ref(null)
  const profileLoading = ref(false)
  const profileError = ref(null)

  // Central storage for movie interactions
  const userInteractions = ref(new Map())

  // User lists for different types of interactions
  const userLists = ref({
    watchlist: {
      movies: [],
      meta: {
        currentPage: 1,
        totalPages: 1,
        totalCount: 0,
        perPage: 10
      }
    },
    favorites: {
      movies: [],
      meta: {
        currentPage: 1,
        totalPages: 1,
        totalCount: 0,
        perPage: 10
      }
    },
    ratings: {
      movies: [],
      meta: {
        currentPage: 1,
        totalPages: 1,
        totalCount: 0,
        perPage: 10
      }
    }
  })

  // Loading states for various operations
  const loading = ref({
    interactions: new Map(),
    lists: {
      watchlist: false,
      favorites: false,
      ratings: false
    }
  })

  // Error states for various operations
  const errors = ref({
    interactions: new Map(),
    lists: {
      watchlist: null,
      favorites: null,
      ratings: null
    }
  })

  // Helper function to get or create an interaction object for a movie
  const getOrCreateInteraction = (slug) => {
    if (!userInteractions.value.has(slug)) {
      userInteractions.value.set(slug, {
        is_favorite: false,
        in_watchlist: false,
        user_rating: null,
        average_rating: null
      })
    }
    return userInteractions.value.get(slug)
  }

  // Set loading state for a specific movie interaction
  const setInteractionLoading = (slug, isLoading) => {
    loading.value.interactions.set(slug, isLoading)
  }

  // Set error state for a specific movie interaction
  const setInteractionError = (slug, error) => {
    if (error) {
      errors.value.interactions.set(slug, error)
    } else {
      errors.value.interactions.delete(slug)
    }
  }

  // Fetch user interactions for a specific movie
  const fetchInteractions = async (slug) => {
    if (!authStore.isAuthenticated) {
      return null
    }

    setInteractionLoading(slug, true)
    setInteractionError(slug, null)

    try {
      // Fetch all interactions in parallel using userApiService
      const [favoriteResponse, watchlistResponse, ratingResponse] = await Promise.all([
        userApiService.getFavoriteStatus(slug),
        userApiService.getWatchlistStatus(slug),
        userApiService.getRating(slug)
      ])

      const interactionData = {
        is_favorite: favoriteResponse.success ? favoriteResponse.favorite.is_favorite : false,
        in_watchlist: watchlistResponse.success ? watchlistResponse.watchlist.in_watchlist : false,
        user_rating: ratingResponse.success && ratingResponse.rating.is_rated ? ratingResponse.rating.score : null,
        average_rating: ratingResponse.success ? ratingResponse.rating.average_rating : null
      }

      const interaction = updateMovieInteractions(slug, interactionData)
      return interaction
    } catch (error) {
      const errorMessage = error.message || 'Failed to fetch user interactions'
      setInteractionError(slug, errorMessage)
      console.error(`Error fetching interactions for ${slug}:`, error)
      return null
    } finally {
      setInteractionLoading(slug, false)
    }
  }

  // Toggle favorite status for a movie
  const toggleFavorite = async (slug) => {
    if (!authStore.isAuthenticated) {
      throw new Error('Authentication required')
    }

    setInteractionLoading(slug, true)
    setInteractionError(slug, null)

    try {
      const interaction = getOrCreateInteraction(slug)
      const currentStatus = interaction.is_favorite

      // Make API call to toggle favorite status
      const response = currentStatus
        ? await userApiService.removeFromFavorites(slug)
        : await userApiService.addToFavorites(slug)

      if (response.success) {
        // Update interaction state
        interaction.is_favorite = !currentStatus

        // Determine which page to refetch
        if (userLists.value.favorites.movies.length > 0) {
          // Check if we're currently on the favorites list
          const isOnFavoritesList = userLists.value.favorites.movies.some(movie => movie.slug === slug)

          if (isOnFavoritesList) {
            // Domestic toggle: refetch current page
            await fetchUserList('favorites', userLists.value.favorites.meta.currentPage)
          } else {
            // Foreign toggle: refetch first page if adding to favorites
            if (!currentStatus) {  // Adding to favorites
              await fetchUserList('favorites', 1)
            }
          }
        }

        return { success: true, is_favorite: interaction.is_favorite }
      } else {
        throw new Error(response.error || 'Failed to toggle favorite status')
      }
    } catch (error) {
      const errorMessage = error.message || 'Error toggling favorite status'
      setInteractionError(slug, errorMessage)
      console.error(`Error toggling favorite for ${slug}:`, error)
      return { success: false, error: errorMessage }
    } finally {
      setInteractionLoading(slug, false)
    }
  }

  // Toggle watchlist status for a movie
  const toggleWatchlist = async (slug) => {
    if (!authStore.isAuthenticated) {
      throw new Error('Authentication required')
    }

    setInteractionLoading(slug, true)
    setInteractionError(slug, null)

    try {
      const interaction = getOrCreateInteraction(slug)
      const currentStatus = interaction.in_watchlist

      // Make API call to toggle watchlist status
      const response = currentStatus
        ? await userApiService.removeFromWatchlist(slug)
        : await userApiService.addToWatchlist(slug)

      if (response.success) {
        // Update interaction state
        interaction.in_watchlist = !currentStatus

        // Determine which page to refetch
        if (userLists.value.watchlist.movies.length > 0) {
          // Check if we're currently on the watchlist
          const isOnWatchlist = userLists.value.watchlist.movies.some(movie => movie.slug === slug)

          if (isOnWatchlist) {
            // Domestic toggle: refetch current page
            await fetchUserList('watchlist', userLists.value.watchlist.meta.currentPage)
          } else {
            // Foreign toggle: refetch first page if adding to watchlist
            if (!currentStatus) {  // Adding to watchlist
              await fetchUserList('watchlist', 1)
            }
          }
        }

        return { success: true, in_watchlist: interaction.in_watchlist }
      } else {
        throw new Error(response.error || 'Failed to toggle watchlist status')
      }
    } catch (error) {
      const errorMessage = error.message || 'Error toggling watchlist status'
      setInteractionError(slug, errorMessage)
      console.error(`Error toggling watchlist for ${slug}:`, error)
      return { success: false, error: errorMessage }
    } finally {
      setInteractionLoading(slug, false)
    }
  }

  // Set rating for a movie
  const setRate = async (slug, rate) => {
    if (!authStore.isAuthenticated) {
      throw new Error('Authentication required')
    }

    setInteractionLoading(slug, true)
    setInteractionError(slug, null)

    try {
      // Make API call to set rating
      const response = await userApiService.setRate(slug, rate)

      if (response.success) {
        const interaction = getOrCreateInteraction(slug)

        // Update interaction state
        interaction.user_rating = response.rating.score

        // Update average rating if available
        if (response.rating.average_rating !== undefined) {
          interaction.average_rating = response.rating.average_rating

          // Update movie store with new average rating
          const movieStore = useMovieStore()
          movieStore.updateAverageRating(slug, response.rating.average_rating)
        }

        // Determine which page to refetch
        if (userLists.value.ratings.movies.length > 0) {
          // Check if we're currently on the ratings list
          const isOnRatingsList = userLists.value.ratings.movies.some(movie => movie.slug === slug)

          if (isOnRatingsList) {
            // Domestic toggle: refetch current page
            await fetchUserList('ratings', userLists.value.ratings.meta.currentPage)
          } else {
            // Foreign toggle: refetch first page since we're adding a rating
            await fetchUserList('ratings', 1)
          }
        }

        return {
          success: true,
          user_rating: rate,
          average_rating: interaction.average_rating
        }
      } else {
        throw new Error(response.error || 'Failed to set rating')
      }
    } catch (error) {
      const errorMessage = error.message || 'Error setting rating'
      setInteractionError(slug, errorMessage)
      console.error(`Error setting rating for ${slug}:`, error)
      return { success: false, error: errorMessage }
    } finally {
      setInteractionLoading(slug, false)
    }
  }

  // Remove rating for a movie
  const unsetRate = async (slug) => {
    if (!authStore.isAuthenticated) {
      throw new Error('Authentication required')
    }

    setInteractionLoading(slug, true)
    setInteractionError(slug, null)

    try {
      // Make API call to remove rating
      const response = await userApiService.unsetRate(slug)

      if (response.success) {
        const interaction = getOrCreateInteraction(slug)

        // Update interaction state
        interaction.user_rating = null

        // Update average rating if available
        if (response.rating && response.rating.average_rating !== undefined) {
          interaction.average_rating = response.rating.average_rating

          // Update movie store with new average rating
          const movieStore = useMovieStore()
          movieStore.updateAverageRating(slug, response.rating.average_rating)
        }

        // Determine which page to refetch
        if (userLists.value.ratings.movies.length > 0) {
          // Check if we're currently on the ratings list
          const isOnRatingsList = userLists.value.ratings.movies.some(movie => movie.slug === slug)

          if (isOnRatingsList) {
            // Domestic toggle: refetch current page
            await fetchUserList('ratings', userLists.value.ratings.meta.currentPage)
          }
        }

        return { success: true, average_rating: interaction.average_rating }
      } else {
        throw new Error(response.error || 'Failed to remove rating')
      }
    } catch (error) {
      const errorMessage = error.message || 'Error removing rating'
      setInteractionError(slug, errorMessage)
      console.error(`Error unsetting rating for ${slug}:`, error)
      return { success: false, error: errorMessage }
    } finally {
      setInteractionLoading(slug, false)
    }
  }

  // Update interaction data for a movie
  const updateMovieInteractions = (slug, data) => {
    const interaction = getOrCreateInteraction(slug)

    // Update with the provided data
    if (data.is_favorite !== undefined) interaction.is_favorite = data.is_favorite
    if (data.in_watchlist !== undefined) interaction.in_watchlist = data.in_watchlist
    if (data.user_rating !== undefined) interaction.user_rating = data.user_rating
    if (data.average_rating !== undefined) interaction.average_rating = data.average_rating

    return interaction
  }

  // Fetch a user list (favorites, watchlist, or ratings)
  const fetchUserList = async (listType, page = 1, username = null) => {
    const user = username || authStore.user?.username

    if (!user) {
      throw new Error('Username is required')
    }

    loading.value.lists[listType] = true
    errors.value.lists[listType] = null

    try {
      const response = await userApiService.getUserList(user, listType, page)
      if (response.success) {
        // Update the list with new data
        userLists.value[listType] = {
          movies: response.movies,
          meta: response.meta
        }

        // Update the interactions map with data from the list
        response.movies.forEach(movie => {
          if (movie.user_interactions) {
            const interactionData = {
              is_favorite: movie.user_interactions.is_favorite,
              in_watchlist: movie.user_interactions.in_watchlist,
              user_rating: movie.user_interactions.user_rating,
              average_rating: movie.average_rating
            }

            updateMovieInteractions(movie.slug, interactionData)
          }
        })

        return { success: true, data: response }
      } else {
        throw new Error(response.error || `Failed to fetch ${listType}`)
      }
    } catch (error) {
      const errorMessage = error.message || `Error fetching ${listType}`
      errors.value.lists[listType] = errorMessage
      console.error(`Error fetching ${listType}:`, error)
      return { success: false, error: errorMessage }
    } finally {
      loading.value.lists[listType] = false
    }
  }

  // Fetch a user's profile information
  const fetchUserProfile = async (username) => {
    if (!username) {
      throw new Error('Username is required')
    }

    profileLoading.value = true
    profileError.value = null

    try {
      const response = await userApiService.getUser(username)

      if (response.success) {
        userProfile.value = response.user
        return { success: true, user: response.user }
      } else {
        throw new Error(response.error || 'Failed to fetch user profile')
      }
    } catch (error) {
      const errorMessage = error.message || 'Error fetching user profile'
      profileError.value = errorMessage
      console.error(`Error fetching profile for ${username}:`, error)
      return { success: false, error: errorMessage }
    } finally {
      profileLoading.value = false
    }
  }

  // Create computed properties for a movie's interactions
  const movieInteractionsComputed = (slug) => {
    getOrCreateInteraction(slug)

    return {
      isFavorite: computed(() => userInteractions.value.get(slug)?.is_favorite || false),
      isInWatchlist: computed(() => userInteractions.value.get(slug)?.in_watchlist || false),
      userRating: computed(() => userInteractions.value.get(slug)?.user_rating || null),
      averageRating: computed(() => userInteractions.value.get(slug)?.average_rating || null),
      isLoading: computed(() => loading.value.interactions.get(slug) || false),
      error: computed(() => errors.value.interactions.get(slug) || null)
    }
  }

// Create computed properties for a list (favorites, watchlist, or ratings)
  const listComputed = (listType) => ({
    movies: computed(() => userLists.value[listType].movies || []),
    meta: computed(() => userLists.value[listType].meta || {}),
    isLoading: computed(() => loading.value.lists[listType] || false),
    error: computed(() => errors.value.lists[listType] || null)
  })

  // Computed properties for user profile
  const userProfileComputed = computed(() => userProfile.value)
  const isProfileLoading = computed(() => profileLoading.value)
  const profileErrorMessage = computed(() => profileError.value)

  // Update a movie's average rating
  const updateMovieAverageRating = (slug, averageRating) => {
    if (slug && averageRating !== undefined) {
      const interaction = getOrCreateInteraction(slug)
      interaction.average_rating = averageRating
      return true
    }
    return false
  }

  // Return the public interface of the store
  return {
    fetchInteractions,
    toggleFavorite,
    toggleWatchlist,
    setRate,
    unsetRate,
    fetchUserList,
    movieInteractionsComputed,
    listComputed,
    updateMovieAverageRating,
    updateMovieInteractions,
    fetchUserProfile,
    userProfileComputed,
    isProfileLoading,
    profileErrorMessage
  }
})