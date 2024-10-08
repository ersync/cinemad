import {ref} from 'vue'

export function useRateAnimation() {
  const displayedRate = ref(0)
  let currentAnimation = null

  const animateRate = (start, end) => {
    // Ensure that start and end are within valid range [0, 100]
    if (start < 0 || start > 100 || end < 0 || end > 100) {
      console.error('Invalid start or end value. Must be between 0 and 100.')
      return
    }

    // Stop the current animation if it's already running
    if (currentAnimation) {
      clearInterval(currentAnimation)
    }

    // Calculate the range and step time safely
    const range = Math.abs(end - start)
    const increment = end > start ? 1 : -1
    const stepTime = range === 0 ? 0 : Math.abs(Math.floor(3000 / range))

    // Set the starting value
    displayedRate.value = start

    currentAnimation = setInterval(() => {
      if (displayedRate.value > 100) {
        displayedRate.value = 0
        clearInterval(currentAnimation)
        currentAnimation = null
      } else if (displayedRate.value === end) {
        clearInterval(currentAnimation)
        currentAnimation = null
      } else {
        displayedRate.value += increment
      }
    }, stepTime)
  }

  return {
    displayedRate,
    animateRate
  }
}
