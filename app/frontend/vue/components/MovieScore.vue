<template>
  <div class="flex justify-center items-center gap-x-1">
    <div href="#" class="flex justify-center items-center hover:scale-110 cursor-pointer transition-all mr-1 sm:mr-0">
      <div class="consensus">
        <div :class="['outer_ring', props.chartSize]">
          <div
              v-easy-pie-chart="{ percent: avgRate, lineWidth: props.lineWidth, duration: 4000, size: props.size }"
              class="font-ConcenBold text-white -tracking-[6px] pr-1 sm:pr-0 pt-2 movie_avg_rate flex justify-center items-center pl-0.5"
          >
            <span v-cloak>{{ displayedRate }}</span><span v-cloak class="mb-5">%</span>
          </div>
        </div>
      </div>
    </div>
    <span class="block font-SourceProBold leading-[10px]">User <span class="hidden sm:block"><br></span> Score</span>
  </div>
</template>

<script setup>
import {computed, watch, ref} from "vue"
import {storeToRefs} from 'pinia'
import {useRateAnimation} from '@/vue/composables/useRateAnimation'
import {useMovieStore} from "@/vue/stores/movieStore"

const props = defineProps({
  movieId: {
    type: String,
    required: true
  },
  lineWidth: {
    type: Number,
    required: true
  },
  size: {
    type: Number,
    required: true
  },
  chartSize: {
    type: String,
    default: 'big-chart'
  },
  triggerAnimation: {
    type: Boolean,
    default: false
  }
})

const store = useMovieStore()

const {avgRate} = storeToRefs(store.movieComputed(props.movieId))
const {displayedRate, animateRate} = useRateAnimation()

watch(avgRate, (newValue) => {
  props.triggerAnimation ? animateRate(displayedRate.value, newValue) : null
})
console.log(2, props.triggerAnimation)
watch(() => props.triggerAnimation, (newValue) => {
  console.log("1", props.triggerAnimation)
  if (newValue) {
    animateRate(0, avgRate.value)
  }
}, {immediate: false})
</script>