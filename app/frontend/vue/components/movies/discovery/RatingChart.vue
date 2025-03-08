<template>
  <div
      :class="[
      'rating-chart absolute bottom-[-20px] left-2',
      size === 'small-chart' ? 'w-[38px] h-[38px]' : 'w-[68px] h-[68px]'
    ]"
  >
    <svg viewBox="0 0 36 36" class="circular-chart">
      <path
          d="M18 2.0845
          a 15.9155 15.9155 0 0 1 0 31.831
          a 15.9155 15.9155 0 0 1 0 -31.831"
          class="circle-bg"
      />
      <path
          d="M18 2.0845
          a 15.9155 15.9155 0 0 1 0 31.831
          a 15.9155 15.9155 0 0 1 0 -31.831"
          :stroke-dasharray="`${percentage}, 100`"
          class="circle"
          :class="ratingClass"
      />
      <text x="18" y="20.35" class="percentage">{{ rating }}</text>
    </svg>
  </div>
</template>

<script setup>
import { computed } from 'vue'

const props = defineProps({
  rating: {
    type: Number,
    required: true
  },
  size: {
    type: String,
    default: 'small-chart'
  }
})

const percentage = computed(() => props.rating * 10)

const ratingClass = computed(() => {
  if (props.rating >= 7) return 'high'
  if (props.rating >= 4) return 'medium'
  return 'low'
})
</script>

<style scoped>
.rating-chart {
  background-color: #081c22;
  border-radius: 50%;
  padding: 2px;
}

.circular-chart {
  display: block;
  margin: 0;
}

.circle-bg {
  fill: none;
  stroke: #204529;
  stroke-width: 2.8;
}

.circle {
  fill: none;
  stroke-width: 2.8;
  stroke-linecap: round;
}

.circle.high {
  stroke: #21d07a;
}

.circle.medium {
  stroke: #d2d531;
}

.circle.low {
  stroke: #db2360;
}

.percentage {
  fill: #fff;
  font-family: sans-serif;
  font-size: 0.5em;
  text-anchor: middle;
}
</style>