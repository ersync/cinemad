<template>
  <a href="#" class="flex justify-center items-center hover:scale-110 cursor-pointer transition-all">
    <div class="consensus">
      <div class="outer_ring big-chart">
        <div
            v-easy-pie-chart="{ percent: avgRate, lineWidth: 5, duration: 2000, size: 68 }"
            class="font-ConcenBold text-white -tracking-[7px] pr-1 pt-2 movie_avg_rate flex justify-center items-center pl-0.5"
        >
          <span v-cloak>{{ displayedRate }}</span><span v-cloak class="mb-5">%</span>
        </div>
      </div>
    </div>
  </a>
  <span class="font-SourceProBold ml-1.5 leading-5">User<br/>Score</span>
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