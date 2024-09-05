const {ref, computed, watch} = Vue
import {ratingSteps} from "../../services/ratingSteps"
import {initializeEasyPieChart} from "../../services/easypiechart"
import {getMovieRate, setMovieRate, unsetMovieRate, getAverageRate} from '../services/api'
import {calculateCursorPosition} from '../services/utils'
import {debounce} from 'lodash'

export function useMovieRating(movieId) {
  const rate = ref(0)
  const avgRate = ref(0)
  const rateWidth = computed(() => ratingSteps.find(step => step.rate === rate.value)?.width || 0)
  const hoveredRateWidth = ref(rateWidth.value)

  const fetchInitialRate = async () => {
    try {
      const rateData = await getMovieRate(movieId)
      if (rateData.isRated) {
        rate.value = rateData.score
        hoveredRateWidth.value = rateWidth.value
      }
    } catch (error) {
      console.error('Error fetching initial rate:', error)
    }
  }

  const setRate = debounce(async (event) => {
    const cursorPosition = calculateCursorPosition(event)
    const newRate = ratingSteps.find(ratingStep =>
      cursorPosition > ratingStep.startPercentage && cursorPosition < ratingStep.endPercentage
    )?.rate || 0
    try {
      const {success} = await setMovieRate(movieId, newRate)
      if (success) {
        rate.value = newRate
        await fetchAvgRate()
        resetHoveredRateWidth()
      }
    } catch (error) {
      console.error('Error setting rate:', error)
    }
  }, 300)

  const unsetRate = async () => {
    try {
      const {isRated} = await unsetMovieRate(movieId)
      if (!isRated) {
        rate.value = 0
        await fetchAvgRate()
      }
    } catch (error) {
      console.error('Error unsetting rate:', error)
    }
  }

  const fetchAvgRate = async () => {
    try {
      const {avg_rate} = await getAverageRate(movieId)
      avgRate.value = avg_rate
      initializeEasyPieChart('.big-chart .movie_avg_rate', 68, 5, 2000)
    } catch (error) {
      console.error('Error fetching average rate:', error)
    }
  }

  watch(avgRate, (newRate) => {
    $('.big-chart .movie_avg_rate').data('easyPieChart')?.update(newRate)
  })

  const setHoveredRateWidth = (event) => {
    const cursorPosition = calculateCursorPosition(event)
    hoveredRateWidth.value = ratingSteps.find(step =>
      cursorPosition > step.startPercentage && cursorPosition < step.endPercentage
    )?.width || '0'
  }

  const resetHoveredRateWidth = () => {
    hoveredRateWidth.value = rateWidth.value
  }

  const rateClass = computed(() => `icon-r${avgRate.value}`)

  return {
    rate,
    avgRate,
    rateWidth,
    hoveredRateWidth,
    setRate,
    unsetRate,
    setHoveredRateWidth,
    resetHoveredRateWidth,
    fetchInitialRate,
    fetchAvgRate,
    rateClass
  }
}