<template>
  <div class="flex flex-col relative my-7.5 min-h-[333px] sm:min-h-[370px]" :style="{ height: height || '' }">
    <div class="flex gap-5 items-center">
      <SectionHeading :title="title"/>

    </div>

    <div
        class="fading fade_visible relative"
        ref="wrapperRef"
        :style="backgroundBarStyle"
    >
      <scrollable-wrapper>
        <div class="flex gap-5 mt-5">
          <movie-card
              v-for="movie in displayedMovies"
              :key="movie.id"
              :movie="movie"
          />
        </div>
      </scrollable-wrapper>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from 'vue'
import MovieCard from '@/vue/components/movies/homepage/MovieCard.vue'
import TabSelector from '@/vue/components/movies/shared/TabSelector.vue'
import ScrollableWrapper from '@/vue/components/movies/shared/ScrollableWrapper.vue'
import { useErrorHandler } from '@/vue/composables/useErrorHandler'
import { useMovieStore } from '@/vue/stores/movieStore'
import { shuffle } from 'lodash'
import SectionHeading from "@/vue/components/movies/show/SectionHeading.vue"

import trendingBackground from "@/assets/images/trending_background.png"

const props = defineProps({
  title: {
    type: String,
    required: true
  },
  periods: {
    type: Array,
    default: () => []
  },
  movies: {
    type: Array,
    required: true
  },
  height: {
    type: String,
    default: ''
  },
  showScrollbar: {
    type: Boolean,
    default: false
  },
  backgroundBar: {
    type: Boolean,
    default: false
  }
})

const { handleError } = useErrorHandler()
const movieStore = useMovieStore()
const selectedPeriod = ref(props.periods[0]?.toLowerCase().replace(' ', '_') || '')
const wrapperRef = ref(null)

const displayedMovies = computed(() => {
  try {
    if (!props.movies || props.movies.length === 0) {
      return []
    }
    return shuffle(props.movies)
  } catch (error) {
    handleError(error)
    return []
  }
})

const backgroundBarStyle = computed(() => {
  if (!props.backgroundBar) return {}
  return {
    background: `url(${trendingBackground}) -10px 130px / contain no-repeat`
  }
})

const handlePeriodChange = (newPeriod) => {
  selectedPeriod.value = newPeriod
}

const handleFading = (wrapper) => {
  const leftHorizontalOffset = wrapper.scrollLeft
  if (leftHorizontalOffset > 45) {
    wrapperRef.value.classList.add('fade_invisible')
    wrapperRef.value.classList.remove('fade_visible')
  } else {
    wrapperRef.value.classList.add('fade_visible')
    wrapperRef.value.classList.remove('fade_invisible')
  }
}

onMounted(() => {
  const wrapper = wrapperRef.value
  const scrollableElement = wrapper.querySelector('.scrollable-wrapper')
  if (scrollableElement) {
    scrollableElement.addEventListener('scroll', () => handleFading(scrollableElement))
  }
})
</script>

<style scoped>

.fading.fade_visible::after {
  transition: linear .3s;
  opacity: 1;
}

.fading.fade_invisible::after {
  transition: linear .3s;
  opacity: 0;
}

.fading::after {
  content: "";
  width: 40px;
  height: 100%;
  position: absolute;
  top: 0;
  right: 0;
  background-image: linear-gradient(to right, rgba(246, 248, 252, 0) 0, #f6f8fc 100%);  will-change: opacity;
  will-change: opacity;
  pointer-events: none;
}
</style>