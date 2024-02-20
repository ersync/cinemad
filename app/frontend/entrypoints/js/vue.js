const {ref, onMounted, computed, watch} = Vue
import {ratingSteps} from "./ratingSteps"
import Fetch from './fetch'
import NProgress from "nprogress"
import 'nprogress/nprogress.css'
import {initializeEasyPieChart} from "../easypiechart"
import _ from 'lodash'

export function setupApp() {
  // Define reactive variables
  const isFavorite = ref(false)
  const isInWatchlist = ref(false)
  const rate = ref(0)
  const avgRate = ref(0)

  // Calculate width of rate based on ratingSteps
  const rateWidth = computed(() => ratingSteps.find(step => step.rate === rate.value)?.width || 0)

  // Initialize hovered rate and its width
  const hoveredRate = ref(rate.value)
  const hoveredRateWidth = ref(rateWidth.value)

  // Get movie ID from DOM
  const movieId = document.getElementById('app1').getAttribute('data-movie-id')

  // Fetch initial states of favorite, watchlist, and rate
  const fetchInitialStates = async () => {
    try {
      const [rateData, favoriteData, watchlistData] = await Promise.all([
        Fetch.get(`/movies/${movieId}/rate`),
        Fetch.get(`/movies/${movieId}/favorite`),
        Fetch.get(`/movies/${movieId}/watchlist`)
      ])
      // Handle rate data
      if (rateData.isRated) {
        rate.value = rateData.rate
        hoveredRateWidth.value = rateWidth.value
      }

      // Handle favorite and watchlist data
      isFavorite.value = favoriteData.isFavorite
      isInWatchlist.value = watchlistData.isInWatchlist
    } catch (error) {
      console.error('Error fetching initial data:', error)
    }
  }

  // Set rate of the movie
  const setRate = _.debounce(async (event) => {
    try {
      NProgress.start()
      const cursorPosition = calculateCursorPosition(event)
      const newRate = ratingSteps.find(ratingStep => cursorPosition > ratingStep.startPercentage && cursorPosition < ratingStep.endPercentage)?.rate || 0
      const {success} = await Fetch.post(`/movies/${movieId}/rate?rate=${newRate}`)
      if (success) {
        NProgress.done()
        rate.value = newRate
        fetchAvgRate(movieId)
        resetHoveredRateWidth()
      } else {
        throw new Error('Failed to set movie rate')
      }
    } catch (error) {
      console.error('Error setting movie rate:', error)
    }
  }, 300)

  // Unset rate of the movie
  const unsetRate = async (event) => {
    try {
      NProgress.start()
      const {isRated} = await Fetch.delete(`/movies/${movieId}/rate`)
      if (!isRated) {
        NProgress.done()
        rate.value = 0
        fetchAvgRate(movieId)
        throw new Error('Failed to unset movie rate')
      }
    } catch (error) {
      console.error('Error unsetting movie rate:', error)
    }
  }

  // Fetch average rate of the movie
  const fetchAvgRate = async (id) => {
    try {
      const {avg_rate} = await Fetch.get(`/movies/${id}/avg_rate`)
      avgRate.value = avg_rate
      initializeEasyPieChart('.big-chart .movie_avg_rate', 68, 5, 2000)
    } catch (error) {
      console.error('Error fetching average movie score:', error)
    }
  }

  // Watch for changes in average rate and update EasyPieChart accordingly
  watch(avgRate, (newRate) => {
    $('.big-chart .movie_avg_rate').data('easyPieChart')?.update(newRate)
  })

  // Update state of favorite or watchlist
  const updateState = async (endpoint, action, stateVariable, id) => {
    try {
      if (endpoint !== 'watchlist' && endpoint !== 'favorite') {
        throw new Error('Invalid endpoint')
      }
      if (!['post', 'delete'].includes(action)) {
        throw new Error('Invalid action')
      }
      NProgress.start()

      const csrfToken = document.querySelector('meta[name="csrf-token"]').content
      const response = await Fetch[action](`/movies/${id}/${endpoint}`, null, {
        headers: {'X-CSRF-Token': csrfToken}
      })
      if (response.success) {
        NProgress.done()
        if (stateVariable === 'isInWatchlist') {
          isInWatchlist.value = response.isInWatchlist
        } else if (stateVariable === 'isFavorite') {
          isFavorite.value = response.isFavorite
        }
      } else {
        throw new Error(`Failed to update ${stateVariable} (action: ${action})`)
      }
    } catch (error) {
      console.error(`Error updating ${stateVariable} (action:${action}):`, error)
    }
  }

  // Toggle watchlist status
  const toggleWatchlist = _.debounce(() => {
    isInWatchlist.value ? updateState('watchlist', 'delete', 'isInWatchlist', movieId)
      : updateState('watchlist', 'post', 'isInWatchlist', movieId)
  }, 200)

  // Toggle favorite status
  const toggleFavorite = _.debounce(() => {
    isFavorite.value ? updateState('favorite', 'delete', 'isFavorite', movieId)
      : updateState('favorite', 'post', 'isFavorite', movieId)
  }, 200)

  // Calculate cursor position for rating
  const calculateCursorPosition = (event) => {
    const ratingContainer = document.querySelector(".rating-container")
    const ratingContainerWidth = ratingContainer.offsetWidth
    const mouseX = event.clientX - ratingContainer.getBoundingClientRect().left
    return (mouseX / ratingContainerWidth) * 100
  }

  // Set hovered rate width
  const setHoveredRateWidth = (event) => {
    const cursorPosition = calculateCursorPosition(event)
    hoveredRateWidth.value = ratingSteps.find(step => cursorPosition > step.startPercentage && cursorPosition < step.endPercentage)?.width || '0'

  }

// Reset hovered rate width
  const resetHoveredRateWidth = () => {
    const filledStars = document.querySelector(".filled-stars")
    console.log(hoveredRateWidth.value)
    console.log(rateWidth.value)
    hoveredRateWidth.value = rateWidth.value
  }

  // Fetch initial states when component is mounted
  onMounted(async () => {
    await fetchInitialStates()
    await fetchAvgRate(movieId)
  })

  // Compute rate class
  const rateClass = computed(() => {
    return `icon-r${avgRate.value}`
  })
  return {
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
    unsetRate
  }
}