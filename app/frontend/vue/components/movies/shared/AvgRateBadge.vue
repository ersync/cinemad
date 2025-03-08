<script setup>
import { ref, onMounted, onUnmounted, watch, computed } from 'vue'
import EasyPieChart from 'easy-pie-chart/dist/easypiechart.js'

const instanceId = ref(`chart-${Math.random().toString(36).substr(2, 9)}`)

const props = defineProps({
  averageRating: {
    type: Number,
    required: true
  },
  size: {
    type: String,
    default: 'small-chart',
    validator: (value) => ['big-chart', 'medium-chart', 'base-chart', 'small-chart'].includes(value)
  },
  shouldAnimate: {
    type: Boolean,
    default: true
  }
})

const chartEl = ref(null)
const displayedRate = ref(0)
const isInitialized = ref(false)
const isAnimating = ref(false)
let chartInstance = null
let currentAnimation = null


const validRating = computed(() => {
  const rating = props.averageRating
  const isValid = rating !== null && rating !== undefined && !isNaN(rating) && rating > 0
  return isValid ? rating : null
})

const sizeConfig = {
  'big-chart': { size: 68, lineWidth: 5 },
  'medium-chart': { size: 54, lineWidth: 3 },
  'base-chart': { size: 44, lineWidth: 3 },
  'small-chart': { size: 38, lineWidth: 3 }
}

const initChart = () => {
  if (!chartEl.value || isInitialized.value) {
    return
  }

  const config = sizeConfig[props.size]
  chartInstance = new EasyPieChart(chartEl.value, {
    size: config.size,
    lineWidth: config.lineWidth,
    barColor: (percent) => {
      if (percent >= 70) return '#21d07a'
      if (percent >= 50) return '#d2d531'
      return '#db2360'
    },
    trackColor: '#204529',
    scaleColor: false,
    rotate: 0,
    lineCap: 'butt'
  })

  isInitialized.value = true
}

const updateChart = (rating) => {

  if (isAnimating.value) {
    return
  }

  if (!rating || rating <= 0) {
    return
  }

  if (!chartInstance) {
    initChart()
    if (!chartInstance) {
      return
    }
  }

  if (currentAnimation) {
    cancelAnimationFrame(currentAnimation)
    currentAnimation = null
  }

  if (props.shouldAnimate) {
    isAnimating.value = true
    const startTime = performance.now()
    const duration = 1500
    const startValue = displayedRate.value || 0
    const endValue = rating

    const animate = (currentTime) => {
      const elapsed = currentTime - startTime
      const progress = Math.min(elapsed / duration, 1)
      const currentValue = startValue + (endValue - startValue) * progress

      displayedRate.value = currentValue
      chartInstance.update(currentValue)

      if (progress < 1) {
        currentAnimation = requestAnimationFrame(animate)
      } else {
        currentAnimation = null
        isAnimating.value = false
        displayedRate.value = endValue
      }
    }

    currentAnimation = requestAnimationFrame(animate)
  } else {
    displayedRate.value = rating
    chartInstance.update(rating)
  }
}

const formattedRate = computed(() => {
  const roundedRate = Math.round(displayedRate.value)
  return roundedRate.toString().padStart(2, '0')
})

onMounted(() => {

  initChart()

  if (validRating.value) {
    updateChart(validRating.value)
  }
})

let updateTimeout = null
watch(() => props.averageRating, (newVal, oldVal) => {

  if (updateTimeout) {
    clearTimeout(updateTimeout)
  }

  updateTimeout = setTimeout(() => {
    if (validRating.value) {
      updateChart(validRating.value)
    }
  }, 150)
}, { immediate: true })

onUnmounted(() => {

  if (currentAnimation) {
    cancelAnimationFrame(currentAnimation)
  }
  if (updateTimeout) {
    clearTimeout(updateTimeout)
  }
  if (chartInstance?.destroy) {
    chartInstance.destroy()
    chartInstance = null
  }
})
</script>

<template>
  <div class="consensus" :data-instance-id="instanceId">
    <div :class="['outer_ring', size]">
      <div
          ref="chartEl"
          :class="[
            'movie_avg_rate flex justify-center items-center text-white',
            {
              'text-[16px]': size === 'big-chart',
              'text-[12px]': size === 'medium-chart',
              'text-[10px]': size === 'small-chart'
            }
          ]"
      >
        <span class="absolute block pl-0 font-ConcenBold" :class="{
          'text-[14px] -tracking-[6px] top-[40%] right-[40%]': size === 'big-chart',
          'text-[11px] -tracking-[4px]': size === 'medium-chart',
          'text-[9px] -tracking-[4px] top-[42%] right-[41%]': size === 'small-chart'
        }">{{ formattedRate }}</span>
        <span :class="{
          'relative top-[3%] right-[-20%] mb-5 font-ConcenBold': size === 'big-chart',
          'relative top-[3%] right-[-20%] mb-4 font-ConcenBold': size === 'medium-chart',
          'text-[10px] relative top-[2%] right-[-21%] mb-3 font-ConcenBold': size === 'small-chart'
        }">%</span>
      </div>
    </div>
  </div>
</template>

<style scoped>
.consensus {
  transition: transform .2s;
  transform: scale(1);
}

.outer_ring {
  display: inline-block;
  border-radius: 50%;
  background-color: #081c22;
  position: relative;
}

.big-chart {
  width: 68px !important;
  height: 68px !important;
  text-decoration: none;
}

.medium-chart {
  width: 54px !important;
  height: 54px !important;
  text-decoration: none;
}

.base-chart {
  width: 44px !important;
  height: 44px !important;
  text-decoration: none;
}

.small-chart {
  width: 38px !important;
  height: 38px !important;
  text-decoration: none;
}

.movie_avg_rate {
  position: relative;
  display: inline-block;
  width: 100%;
  height: 100%;
  text-align: center;
  color: #fff;
}

.movie_avg_rate canvas {
  background-color: transparent;
  position: absolute;
  top: 0;
  left: 0;
  padding: 1px !important;
}

.outer_ring.big-chart canvas {
  padding: 5px !important;
}

.outer_ring.small-chart canvas {
  padding: 1px !important;
}

.consensus, .outer_ring, .movie_avg_rate {
  box-sizing: border-box;
}
</style>