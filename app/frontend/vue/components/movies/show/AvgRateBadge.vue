<template>
  <div class="consensus">
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
          'text-[10px] -tracking-[4px] top-[42%] right-[41%]': size === 'small-chart'
        }">{{ formattedRate }}</span>
        <span :class="{
          'relative top-[3%] right-[-20%] mb-5 font-ConcenBold': size === 'big-chart',
          'relative top-[3%] right-[-20%] mb-4 font-ConcenBold': size === 'medium-chart',
          'text-[13px] relative top-[3%] right-[-21%] mb-3 font-ConcenBold': size === 'small-chart'
        }">%</span>
      </div>
    </div>
  </div>
</template>

<script setup>
import {ref, onMounted, onUnmounted, watch, inject, computed} from 'vue'
import EasyPieChart from 'easy-pie-chart/dist/easypiechart.js'
import {useMovieStore} from "@/vue/stores/movieStore"

const movieId = inject("movieId")
const store = useMovieStore()
const {avgRate} = store.movieComputed(movieId.value)

const props = defineProps({
  size: {
    type: String,
    default: 'small-chart',
    validator: (value) => ['big-chart', 'medium-chart', 'base-chart', 'small-chart'].includes(value)
  },
  shouldAnimate: {
    type: Boolean,
    default: true
  },
  animationDelay: {
    type: Number,
    default: 1600
  }
})

const chartEl = ref(null)
const displayedRate = ref(0)
let chart = null

const sizeConfig = {
  'big-chart': {size: 68, lineWidth: 5},
  'medium-chart': {size: 54, lineWidth: 3},
  'base-chart': {size: 44, lineWidth: 3},
  'small-chart': {size: 38, lineWidth: 3}
}

const initChart = () => {
  const config = sizeConfig[props.size]

  chart = new EasyPieChart(chartEl.value, {
    barColor: (percent) => percent < 50 ? '#c4472c' : percent < 70 ? '#C5C82F' : '#66CE79',
    trackColor: "#525151",
    scaleColor: false,
    lineCap: 'circle',
    lineWidth: config.lineWidth,
    size: config.size,
    animate: {duration: 1500, enabled: props.shouldAnimate}
  })

  if (avgRate.value) {
    setTimeout(() => {
      updateChart(avgRate.value)
    }, props.animationDelay)
  }
}

const updateChart = (rating) => {
  if (!chart) return

  chart.update(rating)

  if (props.shouldAnimate) {
    const startTime = performance.now()
    const duration = 1500
    const startValue = 0
    const endValue = rating

    const animate = (currentTime) => {
      const elapsed = currentTime - startTime
      const progress = Math.min(elapsed / duration, 1)
      displayedRate.value = startValue + (endValue - startValue) * progress
      if (progress < 1) requestAnimationFrame(animate)
    }

    requestAnimationFrame(animate)
  } else {
    displayedRate.value = rating
  }
}

const formattedRate = computed(() => {
  const roundedRate = Math.round(displayedRate.value)
  return roundedRate.toString().padStart(2, '0')
})



watch(() => avgRate.value, (newVal) => {
  if (!newVal) return

  if (props.shouldAnimate) {
    setTimeout(() => {
      updateChart(newVal)
    }, props.animationDelay)
  } else {
    updateChart(newVal)
  }
}, {immediate: true})

onMounted(() => {
  initChart()
})

onUnmounted(() => {
  if (chart?.destroy) chart.destroy()
})
</script>

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

/* Ensure the chart container is properly sized */
.consensus, .outer_ring, .movie_avg_rate {
  box-sizing: border-box;
}
</style>