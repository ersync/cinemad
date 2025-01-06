import { defineStore } from 'pinia'
import { ref, computed , toRaw} from 'vue'
import { movieApiService } from '@/services/movieApiService'

export const useMovieStore = defineStore('movieStore', () => {
  const movieStates = ref(new Map())
  const errors = ref(new Map())
  const loading = ref(new Map())

  const getOrCreateMovieState = (movieId) => {
    if (!movieStates.value.has(movieId)) {
      movieStates.value.set(movieId, {
        isFavorite: false,
        isInWatchlist: false,
        userRate: null,
        avgRate: null,
        media: {
          posters: [],
          backdrops: [],
          videos: []
        },
      })
    }
    return movieStates.value.get(movieId)
  }

  const setError = (movieId, error) => errors.value.set(movieId, error)
  const setLoading = (movieId, isLoading) => loading.value.set(movieId, isLoading)






  const executeApiRequest = async (movieId, action, errorMessage) => {
    setLoading(movieId, true);

    try {
      const result = await action();
      setError(movieId, null);
      return result;
    } catch (error) {
      const errorDetails = {
        message: errorMessage,
        details: error.data?.message || error.message
      };
      setError(movieId, errorDetails);
      throw error;
    } finally {
      setLoading(movieId, false);
    }
  };

  const fetchMovieDetails = async (movieId, options = {}) => {
    const defaultOptions = {
      favorite: true,
      watchlist: true,
      rate: true,
      avgRate: true
    };

    const finalOptions = { ...defaultOptions, ...options };

    return executeApiRequest(movieId, async () => {
      const movieState = getOrCreateMovieState(movieId);
      const apiRequests = [];

      if (finalOptions.favorite) {
        apiRequests.push(
          fetchFavoriteStatus(movieId, movieState)
        );
      }

      if (finalOptions.watchlist) {
        apiRequests.push(
          fetchWatchlistStatus(movieId, movieState)
        );
      }

      if (finalOptions.rate) {
        apiRequests.push(
          fetchUserRating(movieId, movieState)
        );
      }

      if (finalOptions.avgRate) {
        apiRequests.push(
          fetchAverageRating(movieId, movieState)
        );
      }

      await Promise.all(apiRequests);
      return movieState;
    }, 'Failed to fetch movie initial state');
  };

  const fetchFavoriteStatus = async (movieId, movieState) => {
    const response = await movieApiService.getFavoriteStatus(movieId);
    movieState.isFavorite = response.isFavorite;
    return response;
  };

  const fetchWatchlistStatus = async (movieId, movieState) => {
    const response = await movieApiService.getWatchlistStatus(movieId);
    movieState.isInWatchlist = response.isInWatchlist;
    return response;
  };

  const fetchUserRating = async (movieId, movieState) => {
    const response = await movieApiService.getRate(movieId);
    movieState.userRate = response.success && response.isRated ? response.score : null;
    return response;
  };

  const fetchAverageRating = async (movieId, movieState) => {
    const response = await movieApiService.getAverageRate(movieId);
    movieState.avgRate = response.average_rating;
    return response;
  };



  // Updated to use new API methods
  const toggleFavorite = async (movieId) => {
    return executeApiRequest(movieId, async () => {
      const movieState = getOrCreateMovieState(movieId)
      const response = movieState.isFavorite
        ? await movieApiService.removeFromFavorites(movieId)
        : await movieApiService.addToFavorites(movieId)

      if (response.success) {
        movieState.isFavorite = !movieState.isFavorite
      }
      return response
    }, 'Failed to toggle favorite status')
  }

  const toggleWatchlist = async (movieId) => {
    return executeApiRequest(movieId, async () => {
      const movieState = getOrCreateMovieState(movieId)
      const response = movieState.isInWatchlist
        ? await movieApiService.removeFromWatchlist(movieId)
        : await movieApiService.addToWatchlist(movieId)

      if (response.success) {
        movieState.isInWatchlist = !movieState.isInWatchlist
      }
      return response
    }, 'Failed to toggle watchlist status')
  }

  const setRate = async (movieId, rate) => {
    return executeApiRequest(movieId, async () => {
      const response = await movieApiService.setRate(movieId, rate)
      if (response.success) {
        getOrCreateMovieState(movieId).userRate = rate
      }
      return response
    }, 'Failed to set rate')
  }

  const unsetRate = async (movieId) => {
    return executeApiRequest(movieId, async () => {
      const response = await movieApiService.unsetRate(movieId)
      if (response.success) {
        getOrCreateMovieState(movieId).userRate = null
      }
      return response
    }, 'Failed to unset rate')
  }

  // Updated media methods to match new API
  const fetchMedia = async (movieId, mediaType) => {
    return executeApiRequest(movieId, async () => {
      let response
      switch (mediaType) {
        case 'popular_media':
          response = await movieApiService.getPopularMedia(movieId)
          break
        case 'posters':
          response = await movieApiService.getPosters(movieId)
          break
        case 'backdrops':
          response = await movieApiService.getBackdrops(movieId)
          break
        case 'videos':
          response = await movieApiService.getVideos(movieId)
          break
        default:
          throw new Error(`Unknown media type: ${mediaType}`)
      }

      if (response.success) {
        return response.urls
      }
      throw new Error(response.error)
    })
  }

  // Computed properties remain the same
  const movieComputed = (movieId) => {
    return {
    isFavorite: computed(() => getOrCreateMovieState(movieId).isFavorite),
    isInWatchlist: computed(() => getOrCreateMovieState(movieId).isInWatchlist),
    userRate: computed(() => getOrCreateMovieState(movieId).userRate),
    avgRate: computed(() => getOrCreateMovieState(movieId).avgRate),
    media: computed(() => getOrCreateMovieState(movieId).media),
    error: computed(() => errors.value.get(movieId)),
    isLoading: computed(() => loading.value.get(movieId)),
    }
  }

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