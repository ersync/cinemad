import {ref} from 'vue'

export function useRateAnimation() {
  const displayedRate = ref(0)
  let currentAnimation = null

  const animateRate = (start, end) => {
    if (currentAnimation) {
      clearInterval(currentAnimation)
    }

    const range = Math.abs(end - start)
    const increment = end > start ? 1 : -1
    const stepTime = range === 0 ? 0 : Math.abs(Math.floor(1000 / range))

    displayedRate.value = start

    currentAnimation = setInterval(() => {
      if (displayedRate.value === end) {
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