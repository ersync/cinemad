<template>
  <div class="flex justify-center items-center gap-x-1">
    <a href="#" class="flex justify-center items-center hover:scale-110 cursor-pointer transition-all mr-1 sm:mr-0">
      <div class="consensus">
        <div :class="['outer_ring', props.chartSize]">
          <div
              v-easy-pie-chart="{ percent: avgRate, lineWidth: props.lineWidth, duration: 2000, size: props.size }"
              class="font-ConcenBold text-white -tracking-[6px] pr-1 sm:pr-0 pt-2 movie_avg_rate flex justify-center items-center pl-0.5"
          >
            <span v-cloak>{{ displayedRate }}</span><span v-cloak class="mb-5">%</span>
          </div>
        </div>
      </div>
    </a>
    <span class="block font-SourceProBold leading-[10px]">User <span class="hidden sm:block"><br></span> Score</span>
  </div>
</template>

<script setup>
import {computed, watch} from "vue"
import {storeToRefs} from 'pinia'
import {useRateAnimation} from '@/vue/composables/useRateAnimation'
import {useMovieStore} from "@/vue/stores/movieStore"

const props = defineProps({
  movieId: {
    type: String,
    required: true
  },
  lineWidth: {
    type: String,
    required: true
  },
  size: {
    type: String,
    required: true
  },
  chartSize: {
    type: String,
    default: 'big-chart'
  }
})

const store = useMovieStore()

const {avgRate} = storeToRefs(store.movieComputed(props.movieId))
const {displayedRate, animateRate} = useRateAnimation()

watch(avgRate, (newValue) => {
  animateRate(displayedRate.value, newValue)
})
</script>

<style scoped>
</style>